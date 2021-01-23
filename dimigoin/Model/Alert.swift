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
import Combine

enum AlertType {
    case success
    case warning
    case danger
    case cancel
    case text
    case logout
    case idCardReadme
}

class AlertManager: ObservableObject {
    @Published var isShowing: Bool = false
    var alertType: AlertType = .warning
    var content: String = "content"
    var sub: String = "sub"
    
    func createAlert(_ content: String, sub: String, _ alertType: AlertType) {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        self.alertType = alertType
        self.content = content
        self.sub = sub
        withAnimation(.spring()) {
            self.isShowing = true
        }
        LOG("Alert presented \(content) : \(sub)")
    }
    
    func logoutCheck() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        self.alertType = .logout
        self.content = "정말 로그아웃 하시겠습니까?"
        withAnimation(.spring()) {
            self.isShowing = true
        }
        LOG("Alert presented \(content)")
    }
    func idCardReadme() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        self.alertType = .idCardReadme
        withAnimation(.spring()) {
            self.isShowing = true
        }
    }
    func dismiss() {
        withAnimation(.spring()) {
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
            case .idCardReadme: colorName = "accent"
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
