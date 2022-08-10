//
//  HomeView.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/7/19.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var homeVM: HomeViewModel
    
    @State private var showAddTranscationView: Bool = false
    @State private var showInformationView: Bool = false
    @State private var showBalanceTypes: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                headerSection
                
                balanceSection
                
                transcationTitle
                
                transcationList
            }
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}


extension HomeView {
    private var headerSection: some View {
        HStack {
            Button {
                showInformationView.toggle()
            } label: {
                MaterialButtonView(iconName: "info")
            }
            
            Spacer()
            Text("總覽")
                .font(.title2)
                .bold()
            
            Spacer()
            Button {
                showAddTranscationView.toggle()
            } label: {
                MaterialButtonView(iconName: "plus")
            }
        }
        .font(.headline)
        .sheet(isPresented: $showAddTranscationView) {
            AddTranscationView(title: "新增交易紀錄")
        }
        .sheet(isPresented: $showInformationView) {
            InformationView()
        }
    }
    
    private var balanceSection: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 25)
                .fill(Color.theme.chart)
                .frame(width: 250, height: 250)
    
            Circle()
                .trim(from: 0, to: homeVM.progress)
                .stroke(style: StrokeStyle(lineWidth: 30, lineCap: .round))
                .fill(Color.theme.progress)
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(-90))
            
            VStack {
                HStack {
                    Text(homeVM.balanceType.rawValue)
                    Image(systemName: "arrowtriangle.down.fill")
                        .frame(width: 5)
                    
                }
                .font(.headline)
                .padding(10)
                .onTapGesture {
                    showBalanceTypes.toggle()
                }
                
                Text("$ \(homeVM.updateBalance().formatted())")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                
                HStack {
                    Circle()
                        .fill(Color.theme.chart)
                        .frame(width: 15, height: 15)
                    
                    Text("收入")
                        .bold()
                    
                    Circle()
                        .fill(Color.theme.progress)
                        .frame(width: 15, height: 15)
                    
                    Text("支出")
                        .bold()
                }
                .font(.caption2)
                .padding(.top)
            }
            .confirmationDialog("選擇類型", isPresented: $showBalanceTypes) {
                Button("支出") {
                    homeVM.changeBalanceType(type: .expense)
                }
                Button("收入") {
                   homeVM.changeBalanceType(type: .income)
                }
                Button("結餘") {
                   homeVM.changeBalanceType(type: .balance)
                }
            }
        }
        .padding(.bottom, 30)
    }
    
    private var transcationTitle: some View {
        VStack {
            SearchBarView(placeholder: "搜尋一筆交易", searchText: $homeVM.searchText)
                .padding(.bottom)
            
            HStack {
                Text("交易紀錄")
                    .bold()
                
                
                Spacer()
                
                Label("排序", systemImage: "arrow.up.arrow.down")
                    .foregroundColor(.secondary)
                    .contextMenu {
                        Button("預設：時間(最近至最遠)") {
                            homeVM.sortOptions = .time
                        }
                        
                        Button("時間(最遠至最近)") {
                            homeVM.sortOptions = .timeReversed
                        }
                        
                        Button("金額(最高至最低)") {
                            homeVM.sortOptions = .price
                        }
                        
                        Button("金額(最低至最高)") {
                            homeVM.sortOptions = .priceReversed
                        }
                    }
                
            }
            .font(.callout)
        }
        .padding(.horizontal)
    }
    
    private var transcationList: some View {
        List {
            ForEach(homeVM.allTranscations, id: \.id) { item in
                NavigationLink {
                    DetailView(transcation: item)
                } label: {
                    TranscationListView(transcation: item)
                }
                .listRowSeparator(.hidden)
            }
            .onDelete(perform: homeVM.deletePayment)
        }
        .listStyle(.plain)
    }
}
