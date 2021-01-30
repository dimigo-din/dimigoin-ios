//
//  Alert.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/09.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation
import DimigoinKit
import SwiftUI

enum AlertType {
    case success
    case warning
    case danger
    case cancel
    case text
    case logout
    case idCardReadme
    case attendance
}

class AlertManager: ObservableObject {
    @Published var isShowing: Bool = false
    var alertType: AlertType = .warning
    var content: String = "content"
    var sub: String = ""
    
    func createAlert(_ content: String, sub: String, _ alertType: AlertType) {
        self.alertType = alertType
        self.content = content
        self.sub = sub
        showAlert()
        print("Alert presented \(content) : \(sub)")
    }
    
    func createAlert(_ content: String, _ alertType: AlertType) {
        self.alertType = alertType
        self.content = content
        self.sub = ""
        showAlert()
        print("Alert presented \(content) : \(sub)")
    }
    
    func logoutCheck() {
        self.alertType = .logout
        self.content = "정말 로그아웃 하시겠습니까?"
        showAlert()
        print("Alert presented \(content)")
    }
    func idCardReadme() {
        self.alertType = .idCardReadme
        showAlert()
    }
    func attendance() {
        self.alertType = .attendance
        showAlert()
    }
    func showAlert() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        withAnimation(.easeInOut(duration: 0.25)) {
            self.isShowing = true
        }
    }
    func dismiss() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        withAnimation(.easeInOut(duration: 0.25)) {
            self.isShowing = false
        }
    }
    func getAccentColor() -> Color {
        var colorName: String = "purple"
        switch alertType {
            case .cancel: colorName = "gray4"
            case .success: colorName = "accent"
            case .warning: colorName = "yellow"
            case .danger: colorName = "red"
            case .text: colorName = "accent"
            case .logout: colorName = "accent"
            case .idCardReadme: colorName = "gray4"
            case .attendance: colorName = "accent"
        }
        return Color(colorName)
    }
    
    func getIconName() -> String {
        var iconName: String = ""
        switch alertType {
            case .cancel: iconName = "disabled-checkmark"
            case .success: iconName = "checkmark"
            case .warning: iconName = "warningmark"
            case .danger: iconName = "dangermark"
            case .text: iconName = ""
            case .logout: iconName = "logout"
            case .idCardReadme: iconName = ""
            case .attendance: iconName = ""
        }
        return iconName
    }
    
    func getTitleColor() -> Color {
        if alertType == .success {
            return Color("accent")
        }
        if alertType == .logout {
            return Color.text
        }
        else {
            return Color("gray4")
        }
    }
}
