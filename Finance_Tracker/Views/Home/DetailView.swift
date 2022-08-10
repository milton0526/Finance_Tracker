//
//  DetailView.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/8/5.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    let transcation: Transcation
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    @State private var showEditView: Bool = false
    
    var body: some View {
        VStack {
            headerSection
            
            Image(transcation.type == 0 ? "expense" : "income")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height / 4)
                .cornerRadius(15)
                .padding(.horizontal)
            
            LazyVGrid(columns: columns) {
                StaticsView(title: "類型", detail: transcation.type == 0 ? "支出" : "收入")
                
                StaticsView(title: "名稱", detail: transcation.name ?? "")
                
                StaticsView(title: "金額", detail: "$ \(transcation.amount.formatted())")
                
                StaticsView(title: "日期", detail: (transcation.date ?? .now).asShortDateString())
                    
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let homeVM = HomeViewModel()
    
    static var previews: some View {
        DetailView(transcation: homeVM.allTranscations[0])
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
            
            Text(transcation.name ?? "")
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
            EditTranscationView(transcation: transcation)
        }
    }
}
