//
//  Color.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/7/20.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = Theme()
}

struct Theme {
    let chart = Color("ChartColor")
    let progress = Color("ProgressColor")
    let sectionBackground = Color("BackgroundColor")
    let selected = Color("SelectedColor")
}
