//
//  InformationView.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/8/10.
//

import SwiftUI

struct InformationView: View {
    @Environment(\.dismiss) var dismiss
    
    let url: URL = URL(string: "https://icons8.com")!
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        VStack {
                            Image("icons8")
                                .resizable()
                                .scaledToFit()
                            
                            HStack {
                                Text("Website:")
                                    .font(.title3)
                                    .bold()
                                
                                Link(destination: url) {
                                    Text("Icons8")
                                        .font(.title3)
                                        .underline()
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(4)
                        }
                    } header: {
                        Text("Icon & Illustration")
                    }

                }
            }
            .navigationTitle("Resources")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                       Image(systemName: "xmark")
                    }

                }
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
