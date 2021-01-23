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
}

class AlertManager: ObservableObject {
    @Published var isShowing: Bool = false
    var alertType: AlertType = .warning
    var content: String = "content"
    var sub: String = "sub"
    var count: Int = 0
    
    func createAlert(_ content: String, sub: String, _ alertType: AlertType) {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        self.alertType = alertType
        self.content = content
        self.sub = sub
        withAnimation(.spring()) {
            self.isShowing = true
        }
        self.count += 1
        LOG("Alert presented \(content) : \(sub)")
    }
    func dismiss() {
        withAnimation(.spring()) {
            self.isShowing = false
        }
    }
}
