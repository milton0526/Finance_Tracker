//
//  HomeViewModel.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/7/27.
//

import Foundation
import SwiftUI
import Combine


//  After upadte transcation detail, home view not reload...

class HomeViewModel: ObservableObject {
    private let transcationDataService = TranscationDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    // MARK: HomeView
    @Published var allTranscations: [Transcation] = []
    @Published var progress: CGFloat = 0.0
    @Published var searchText: String = ""
    @Published var balanceType: BalanceTypeName = .balance
    @Published var balance: Double = 0.0
    @Published var totalExpense: Double = 0.0
    @Published var totalIncome: Double = 0.0
    @Published var sortOptions: SortOptions = .time
    
    
    enum BalanceTypeName: String, Identifiable {
        case expense = "支出"
        case income = "收入"
        case balance = "結餘"
        
        var id: Self { self }
    }
    
    enum SortOptions {
        case time, timeReversed, price, priceReversed
    }
    
    
    // Add Subscriber
    func addSubscriber() {
        
        transcationDataService.$transcationRecord
            .combineLatest($searchText, $sortOptions)
            .sink { [weak self] (returnedData, inputSearchText, sortOption) in
                
                // 把資料分類加總，計算出總支出、總收入、結餘
                let income = returnedData.filter({ $0.type == 1 }).reduce(0, { $0 + $1.amount })
                self?.totalIncome = income
                
                let expense = returnedData.filter({ $0.type == 0 }).reduce(0, { $0 + $1.amount })
                self?.totalExpense = expense
                
                let balance = income + expense
                self?.balance = balance
                
                // 百分比動畫
                withAnimation(.linear.delay(0.2)) {
                    self?.progress = CGFloat(abs(expense / income))
                }
                
                // 關鍵字搜尋、排序
                if inputSearchText.isEmpty {
                    switch sortOption {
                    case.time:
                        self?.allTranscations = returnedData.sorted(by: { $0.date ?? .now > $1.date ?? .now })
                    case.timeReversed:
                        self?.allTranscations = returnedData.sorted(by: { $0.date ?? .now < $1.date ?? .now })
                    case.price:
                        self?.allTranscations = returnedData.sorted(by: { $0.amount < $1.amount })
                    case .priceReversed:
                        self?.allTranscations = returnedData.sorted(by: { $0.amount > $1.amount })
                    }
                    
                } else {
                    self?.allTranscations = returnedData.filter({ payment in
                        (payment.name ?? "").contains(inputSearchText)
                    })
                }
            }
            .store(in: &cancellables)
    }

    func changeBalanceType(type: BalanceTypeName) {
        balanceType = type
    }
    
    func updateBalance() -> Double {
        switch balanceType {
        case .expense:
            return totalExpense
        case .income:
            return totalIncome
        case .balance:
            return balance
        }
    }
    
    
    // MARK: AddNewTranscationView
    @Published var nameTextField: String = ""
    @Published var amountTextField: String = ""
    @Published var dateField: Date = .now
    @Published var selectedItem: String? = nil
    @Published var selectedType: TranscationType = .expense
    
    @Published var expenseCategory: [String] = [
        "食物", "飲料", "交通", "社交", "娛樂", "旅遊", "生活用品", "衣物", "購物", "禮品", "投資", "醫療", "運動", "學習", "各項費用", "其他"
    ]
    @Published var incomeCategory: [String] = [
        "薪資", "獎金", "回饋", "利息"
    ]
    
    func check() -> Bool {
        guard selectedItem != nil && !nameTextField.isEmpty && !amountTextField.isEmpty else {
            return true
        }
        return false
    }
    
    func clearSelectedItem() {
        nameTextField = ""
        selectedItem = nil
        amountTextField = ""
    }
    
    func addNewPayment(type: Int64, icon: String, name: String, amount: Double, date: Date) {
        transcationDataService.addNewPayment(type: type, icon: icon, name: name, amount: amount, date: date)
    }
    
    func deletePayment(at offset: IndexSet) {
        for index in offset {
            let payment = allTranscations[index]
            transcationDataService.delete(entity: payment)
        }
    }
    
    func updatePaymentDatail(transcation: Transcation, type: Int64, icon: String, name: String, amount: Double, date: Date) {
        transcationDataService.updateTranscationDetail(transcation: transcation, type: type, icon: icon, name: name, amount: abs(amount), date: date)
    }
    
}

enum TranscationType: Int64, Identifiable {
    case expense = 0
    case income = 1
    var id: Self { self }
}
