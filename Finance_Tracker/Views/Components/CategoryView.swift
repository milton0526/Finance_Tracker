//
//  CategoryView.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/7/25.
//

import SwiftUI

struct CategoryView: View {
    let images: [String]
    @Binding var selectedItem: String?
    @Binding var textField: String
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(images, id: \.self) { image in
                VStack(spacing: 10) {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    
                    Text(image)
                        .font(.subheadline)
                        .bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        selectedItem = image
                        textField = image
                    }
                }
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedItem == image ? Color.theme.selected : Color.clear )
                )
            }
        }
        .padding(.bottom)
    }
}

struct CategoryItemsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryView(images: ["食物", "交通", "醫療", "飲料"], selectedItem: .constant(nil), textField: .constant("Dinner"))
                .previewLayout(.sizeThatFits)
            
            CategoryView(images: ["食物", "交通", "醫療", "飲料"], selectedItem: .constant(nil), textField: .constant("Dinner"))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
        }
    }
}
