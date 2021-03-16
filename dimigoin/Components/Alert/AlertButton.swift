//
//  AlertButton.swift
//  dimigoin
//
//  Created by 변경민 on 2021/03/10.
//  Copyright © 2021 seohun. All rights reserved.
//
import SwiftUI

extension Alert {
    enum ButtonType {
        case `default`
        case cancel
        case warning
        case danger
    }
    enum ButtonPosition {
        case trailing
        case leading
        case center
    }
}

func getButtonBackgroundByPosition(_ position: Alert.ButtonPosition) -> RoundSquare {
    switch position {
    case .center: return RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 10, bottomRight: 10)
    case .trailing: return RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 10)
    case .leading: return RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 10, bottomRight: 0)
    }
}
func getButtonColorByType(_ type: Alert.ButtonType) -> Color {
    switch type {
    case .default: return Color.accent
    case .cancel: return Color.gray4
    case .warning: return Color.yellow
    case .danger: return Color.red
    }
}
