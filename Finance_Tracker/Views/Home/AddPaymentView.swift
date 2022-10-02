//
//  AddPaymentView.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/7/20.
//

import SwiftUI


struct AddPaymentView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var homeVM: HomeViewModel
    
    let title: String
    
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

struct AddNewPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        AddPaymentView(title: "新增交易紀錄")
            .environmentObject(HomeViewModel())
    }
}

extension AddPaymentView {
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
                    homeVM.addNewPayment(type: homeVM.selectedType.rawValue, icon: homeVM.selectedItem ?? "", name: homeVM.nameTextField, amount: Double(homeVM.amountTextField) ?? 0.0, date: homeVM.dateField)
                    
                    dismiss()
                } label: {
                    MaterialButtonView(iconName: "checkmark")
                }
                .disabled(homeVM.check())
            }
            .font(.headline)
            
            Text(title)
                .font(.title)
                .bold()
                .padding(.horizontal)
        }
    }
    
    private var selectedTypeSection: some View {
        Picker("Select type", selection: $homeVM.selectedType) {
            Text("支出").tag(PaymentType.expense)
            Text("收入").tag(PaymentType.income)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    private var categorySection: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                if homeVM.selectedType == .expense {
                    CategoryView(images: homeVM.expenseCategory, selectedItem: $homeVM.selectedItem, textField: $homeVM.nameTextField)
                        
                }
                
                if homeVM.selectedType == .income {
                    CategoryView(images: homeVM.incomeCategory, selectedItem: $homeVM.selectedItem, textField: $homeVM.nameTextField)
                }
            }
            .padding(5)
            .onAppear {
                homeVM.clearSelectedItem()
            }
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
                TextField(homeVM.nameTextField, text: $homeVM.nameTextField)
                    .multilineTextAlignment(.trailing)
                
            }
            .font(.headline)
            .padding(.horizontal, 30)
            
            Divider()
                .padding([.horizontal, .bottom])
            
            
            
            HStack {
                Text("金額")
                Spacer()
                
                TextField("0", text: $homeVM.amountTextField)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numbersAndPunctuation)
                
            }
            .font(.headline)
            .padding(.horizontal, 30)
            
            
            Divider()
                .padding([.horizontal, .bottom])
            
            DatePicker("日期", selection: $homeVM.dateField, displayedComponents: .date)
                .datePickerStyle(.compact)
                .font(.headline)
                .padding(.horizontal, 30)
        }
    }
}
