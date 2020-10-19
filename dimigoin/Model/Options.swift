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
    init() {
//        loadOptions()
    }
//    func saveOptions() -> Void {
//        UserDefaults.standard.setValue(beneduAlert, forKey: "option_beneduAlert")
//        UserDefaults.standard.setValue(displayMode, forKey: "option_displayMode")
//    }
//    func loadOptions() -> Void {
//        self.beneduAlert = UserDefaults.standard.string(forKey: "option_beneduAlert")?.bool ?? true
//        self.displayMode = UserDefaults.standard.string(forKey: "option_displayMode")?.displayMode ?? "whiteMode".displayMode
//    }
}

extension String {
    var bool: Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }
    var displayMode: DisplayMode? {
        switch self.lowercased() {
        case "whiteMode", "1" :
            return .whiteMode
        case "darkMode", "2":
            return .darkMode
        case "systemMode", "3":
            return .systemMode
        default:
            return nil
        }
    }
}
