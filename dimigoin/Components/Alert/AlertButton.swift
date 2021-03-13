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
    }
    public struct Button: View {
        let label: Text
        var buttonType: Alert.ButtonType = .default
        var action: (() -> Void)?

        private init(label: Text, buttonType: Alert.ButtonType, action: (() -> Void)? = {}) {
            self.label = label
            self.buttonType = buttonType
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
                label
                    .frame(minWidth: 150, maxWidth: .infinity, alignment: .center)
                    .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .shadow(radius: 1.0)
            }
            
        }
        
        // button types
        public static func `default`(_ label: Text, action: (() -> Void)? = {}) -> Alert.Button {
            return Alert.Button(label: label, buttonType: .default, action: action)
        }
        
        public static func cancel(_ label: Text, action: (() -> Void)? = {}) -> Alert.Button {
            return Alert.Button(label: label, buttonType: .cancel, action: action)
        }
        
        public static func cancel(_ action: (() -> Void)? = {}) -> Alert.Button {
            return Alert.Button(label: Text("Cancel"), buttonType: .cancel, action: action)
        }
        
    }
    
}
