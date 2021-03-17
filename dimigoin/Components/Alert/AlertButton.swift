//
//  AlertButton.swift
//  dimigoin
//
//  Created by 변경민 on 2021/03/10.
//  Copyright © 2021 seohun. All rights reserved.
//
import SwiftUI

extension AlertView {
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
    
    public struct Button: View {
        let label: String
        var backgroundColor: Color = Color.gray4
        var buttonPosition: AlertView.ButtonPosition = .center
        var action: (() -> Void)?

        init(label: String, color: Color, position: AlertView.ButtonPosition, action: (() -> Void)? = {}) {
            self.label = label
            self.backgroundColor = color
            self.buttonPosition = position
            self.action = action
        }
        
        public var body: some View {
            SystemButton(action: {
                UIApplication.shared.windows.first!.rootViewController?.dismiss(animated: true, completion: nil)
                if let action = self.action {
                    action()
                }
            }) {
                Text(label)
                    .notoSans(.bold, size: 14)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 45)
                    .foregroundColor(Color.systemBackground)
                    .background(getButtonBackgroundByPosition(buttonPosition).fill(backgroundColor))
            }
        }
        
        // button types
        public static func center(_ label: String, action: (() -> Void)? = {}) -> AlertView.Button {
            return AlertView.Button(label: label, color: .gray4, position: .center, action: action)
        }
        
        public static func center(_ label: String, color: Color) -> AlertView.Button {
            return AlertView.Button(label: label, color: color, position: .center)
        }
        
        public static func dismiss() -> AlertView.Button {
            return AlertView.Button(label: "취소", color: .gray4, position: .leading)
        }
        
        public static func ok() -> AlertView.Button {
            return AlertView.Button(label: "확인", color: .accent, position: .trailing)
        }
        
        public static func ok(action: @escaping () -> Void) -> AlertView.Button {
            return AlertView.Button(label: "확인", color: .accent, position: .trailing, action: action)
        }
    }
}

func getButtonBackgroundByPosition(_ position: AlertView.ButtonPosition) -> RoundSquare {
    switch position {
    case .center: return RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 10, bottomRight: 10)
    case .trailing: return RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 10)
    case .leading: return RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 10, bottomRight: 0)
    }
}
func getButtonColorByType(_ type: AlertView.ButtonType) -> Color {
    switch type {
    case .default: return Color.accent
    case .cancel: return Color.gray4
    case .warning: return Color.yellow
    case .danger: return Color.red
    }
}
