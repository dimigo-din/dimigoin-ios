//
//  Alert.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/09.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation
import SwiftUI

enum AlertType {
    case success
    case warning
    case danger
    case cancel
}

class AlertManager: ObservableObject {
    @Published var isShowing: Bool = false
    var alertType: AlertType = .warning
    var content: String = "content"
    var sub: String = "sub"

    func createAlert(_ content: String, sub: String, _ alertType: AlertType) {
        self.alertType = alertType
        self.content = content
        self.sub = sub
        withAnimation(.spring()) {
            self.isShowing = true
        }
        print("Alert presented \(content) : \(sub)")
    }
    func dismiss() {
        self.isShowing = false
    }
}
