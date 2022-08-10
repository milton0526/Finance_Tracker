//
//  TranscationListView.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/7/30.
//

import SwiftUI

struct TranscationListView: View {
    let transcation: Transcation
    
    var body: some View {
        HStack(spacing: 15) {
            Image(transcation.icon ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(8)
                .background(.regularMaterial)
                .cornerRadius(15)
            
            
            VStack(alignment: .leading, spacing: 5) {
                Text(transcation.name ?? "")
                    .font(.headline)
                
                Text(transcation.date?.asShortDateString() ?? "")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            Text("$ \(transcation.amount.formatted())")
                .font(.headline)
                .foregroundColor(transcation.amount < 0 ? .red : .green)
        }
        .padding(5)
        .background(Color.theme.sectionBackground.opacity(0.001))
    }
}

struct TranscationListItemView_Previews: PreviewProvider {
    static let homeVM = HomeViewModel()
    
    static var previews: some View {
        Group {
            TranscationListView(transcation: homeVM.allTranscations[0])
                .padding()
                .previewLayout(.sizeThatFits)
            
            TranscationListView(transcation: homeVM.allTranscations[0])
                .padding()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
