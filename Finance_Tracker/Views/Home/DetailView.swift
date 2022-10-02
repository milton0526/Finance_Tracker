//
//  DetailView.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/8/5.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var payment: Payment
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    @State private var showEditView: Bool = false
    
    var body: some View {
        VStack {
            headerSection
            
            Image(payment.type == 0 ? "expense" : "income")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height / 4)
                .cornerRadius(15)
                .padding(.horizontal)
            
            LazyVGrid(columns: columns) {
                StaticsView(title: "類型", detail: payment.type == 0 ? "支出" : "收入")
                
                StaticsView(title: "名稱", detail: payment
                    .name ?? "")
                
                StaticsView(title: "金額", detail: "$ \(payment.amount.formatted())")
                
                StaticsView(title: "日期", detail: (payment
                    .date ?? .now).asShortDateString())
                    
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let homeVM = HomeViewModel()
    
    static var previews: some View {
        DetailView(payment: homeVM.allPayments[0])
            .environmentObject(HomeViewModel())
    }
}

extension DetailView {
    private var headerSection: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                MaterialButtonView(iconName: "arrow.left")
            }
            Spacer()
            
            Text(payment.name ?? "")
                .font(.title3)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button {
                showEditView.toggle()
            } label: {
                MaterialButtonView(iconName: "pencil")
            }
        }
        .sheet(isPresented: $showEditView) {
            EditPaymentView(payment: payment)
        }
    }
}
