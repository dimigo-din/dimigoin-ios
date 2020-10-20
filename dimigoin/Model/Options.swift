//
//  Options.swift
//  dimigoin
//
//  Created by 변경민 on 2020/10/18.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation

enum DisplayMode: String {
    case whiteMode = "whiteMode"
    case darkMode = "darkMode"
    case systemMode = "systemMode"
}

class OptionAPI: ObservableObject {
    @Published var beneduAlert: Bool = true
    @Published var displayMode: DisplayMode = .whiteMode
    @Published var selectedMode: Int = 0
    var modes = ["화이트모드", "다크모드", "시스템 설정에 맞게"]
    
    init() {
        loadOptions()
    }
    func saveOptions() -> Void {
        print("option saved")
        UserDefaults.standard.setValue(beneduAlert, forKey: "option_beneduAlert")
        UserDefaults.standard.setValue(selectedMode, forKey: "option_displayMode")
    }
    func loadOptions() -> Void {
        print("options loaded")
        self.beneduAlert = UserDefaults.standard.bool(forKey: "option_beneduAlert")
        self.selectedMode = UserDefaults.standard.integer(forKey: "option_displayMode")
    }
}
