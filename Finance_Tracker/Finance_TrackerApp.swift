//
//  Finance_TrackerApp.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/7/19.
//

import SwiftUI

@main
struct Finance_TrackerApp: App {
    @StateObject private var homeVM = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(homeVM)
        }
    }
}
