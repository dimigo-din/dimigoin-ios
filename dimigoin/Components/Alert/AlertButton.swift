//
//  AlertButton.swift
//  dimigoin
//
//  Created by 변경민 on 2021/03/10.
//  Copyright © 2021 seohun. All rights reserved.
//
import SwiftUI

typealias SystemButton = Button

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
        case `default`
    }
    public struct Button: View {
        let label: String
        var buttonType: Alert.ButtonType = .default
        var buttonPosition: Alert.ButtonPosition = .default
        var action: (() -> Void)?

        init(label: String, type: Alert.ButtonType, position: Alert.ButtonPosition, action: (() -> Void)? = {}) {
            self.label = label
            self.buttonType = type
            self.buttonPosition = position
            self.action = action
        }
        
        public var body: some View {
            SystemButton(action: {
                AlertView.currentAlertVCReference?.dismiss(animated: true) {
                    AlertView.currentAlertVCReference = nil
                    if let action = self.action {
                        action()
                    }
                }
            }) {
                Text(label)
                    .notoSans(.bold, size: 14)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 45)
                    .foregroundColor(Color.systemBackground)
                    .background(getButtonBackgroundByPosition(buttonPosition).fill(getButtonColorByType(buttonType)))
            }
            
        }
        func getButtonBackgroundByPosition(_ position: Alert.ButtonPosition) -> RoundSquare {
            switch position {
            case .default: return RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 10, bottomRight: 10)
            case .trailing: return RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 10, bottomRight: 0)
            case .leading: return RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 10)
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
        // button types
        public static func `default`(_ label: String, action: (() -> Void)? = {}) -> Alert.Button {
            return Alert.Button(label: label, type: .default, position: .default, action: action)
        }
    }
    
}
