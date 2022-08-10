//
//  EditTranscationView.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/8/7.
//

import SwiftUI

struct EditTranscationView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var homeVM: HomeViewModel
    
    let transcation: Transcation
    
    @State private var currentType: TranscationType = .expense
    @State private var selectedItem: String? = nil
    @State private var name: String = ""
    @State private var amount: String = ""
    @State private var date: Date = .now
    
    var body: some View {
        VStack {
            headerSection
            
            selectedTypeSection
            
            categorySection
            
            paymentDetailsSection
            
            Spacer()
        }
    }
}

struct EditTranscationView_Previews: PreviewProvider {
    static let homeVM = HomeViewModel()
    
    static var previews: some View {
        EditTranscationView(transcation: homeVM.allTranscations[0])
            .environmentObject(HomeViewModel())
    }
}

// Extension for Views
extension EditTranscationView {
    private var headerSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    MaterialButtonView(iconName: "xmark")
                }
                
                Spacer()
                
                Button {
                    homeVM.updatePaymentDatail(transcation: transcation, type: currentType.rawValue,icon: selectedItem ?? "", name: name, amount: Double(amount) ?? 0.0, date: date)
                    
                    dismiss()
                } label: {
                    MaterialButtonView(iconName: "checkmark")
                }
                .disabled(checkUpdateDetails())
            }
            .font(.headline)
            
            Text("編輯此筆交易")
                .font(.title)
                .bold()
                .padding(.horizontal)
        }
    }
    
    private var selectedTypeSection: some View {
        Picker("Select type", selection: $currentType) {
            Text("支出").tag(TranscationType.expense)
            Text("收入").tag(TranscationType.income)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
        .onAppear {
            currentType = currentSelcetedType(type: transcation.type)
            currentSelectedItem(selectedItem: transcation.icon ?? "", name: transcation.name ?? "", amount: transcation.amount.description, date: transcation.date ?? .now)
        }
    }
    
    private var categorySection: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                if currentType == .expense {
                    CategoryView(images: homeVM.expenseCategory, selectedItem: $selectedItem, textField: $name)
                }
                
                if currentType == .income {
                    CategoryView(images: homeVM.incomeCategory, selectedItem: $selectedItem, textField: $name)
                }
            }
            .padding(5)
        }
        .frame(height: UIScreen.main.bounds.height * 0.3)
        .background(.regularMaterial)
        .cornerRadius(15)
        .padding()
    }
    
    private var paymentDetailsSection: some View {
        VStack {
            HStack {
                Text("名稱")
                Spacer()
                TextField(transcation.name ?? "", text: $name)
                    .multilineTextAlignment(.trailing)
                
            }
            .font(.headline)
            .padding(.horizontal, 30)
            
            Divider()
                .padding([.horizontal, .bottom])
            
            
            
            HStack {
                Text("金額")
                Spacer()
                
                TextField("\(transcation.amount.formatted())", text: $amount)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                
            }
            .font(.headline)
            .padding(.horizontal, 30)
            
            
            Divider()
                .padding([.horizontal, .bottom])
            
            DatePicker("日期", selection: $date, displayedComponents: .date)
                .datePickerStyle(.compact)
                .font(.headline)
                .padding(.horizontal, 30)
        }
    }
}

// Extension for function
extension EditTranscationView {
    
    func currentSelcetedType(type: Int64) -> TranscationType {
        if type == 0 {
            return .expense
        } else {
            return .income
        }
    }
    
    func currentSelectedItem(selectedItem: String, name: String, amount: String, date: Date) {
        self.selectedItem = selectedItem
        self.name = name
        self.amount = amount
        self.date = date
    }
    
    func checkUpdateDetails() -> Bool {
        guard selectedItem != nil && !name.isEmpty && !amount.isEmpty else {
            return true
        }
        return false
    }
}
