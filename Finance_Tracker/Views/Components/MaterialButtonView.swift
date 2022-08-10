//
//  ButtonLabelVIew.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/7/19.
//

import SwiftUI

struct MaterialButtonView: View {
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .frame(width: 50, height: 50)
            .background(.regularMaterial)
            .cornerRadius(15)
            .padding()
        
    }
}

struct MaterialButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MaterialButtonView(iconName: "plus")
            .previewLayout(.sizeThatFits)
            
            MaterialButtonView(iconName: "chevron.down")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
        }
        
    }
}
