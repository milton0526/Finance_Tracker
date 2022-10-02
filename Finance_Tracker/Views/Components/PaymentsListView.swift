//
//  PaymentListView.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/7/30.
//

import SwiftUI

struct PaymentsListView: View {
    let payment: Payment
    
    var body: some View {
        HStack(spacing: 15) {
            Image(payment.icon ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(8)
                .background(.regularMaterial)
                .cornerRadius(15)
            
            
            VStack(alignment: .leading, spacing: 5) {
                Text(payment.name ?? "")
                    .font(.headline)
                
                Text(payment.date?.asShortDateString() ?? "")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            Text("$ \(payment.amount.formatted())")
                .font(.headline)
                .foregroundColor(payment.amount < 0 ? .red : .green)
        }
        .padding(5)
        .background(Color.theme.sectionBackground.opacity(0.001))
    }
}

struct PaymentsListView_Previews: PreviewProvider {
    static let homeVM = HomeViewModel()
    
    static var previews: some View {
        Group {
            PaymentsListView(payment: homeVM.allPayments[0])
                .padding()
                .previewLayout(.sizeThatFits)
            
            PaymentsListView(payment: homeVM.allPayments[0])
                .padding()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
