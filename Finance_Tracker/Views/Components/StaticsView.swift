//
//  StaticsView.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/8/5.
//

import SwiftUI

struct StaticsView: View {
    let title: String
    let detail: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.callout)
                .bold()
                .foregroundColor(.secondary)
            
            Text(detail)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct StaticsView_Previews: PreviewProvider {
    static var previews: some View {
        StaticsView(title: "交易類型", detail: "支出")
    }
}
