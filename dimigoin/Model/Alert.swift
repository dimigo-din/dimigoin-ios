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

typealias SystemButton = Button

public enum Test {
    public static func present() {
        AlertViewController(alertView: Alert(icon: .checkmark, color: .accent, message: "hello")).present()
    }
    
    public static func dismiss() {
//        AlertViewController.dismiss(self)
    }
}

public struct Alert: View {
    @State var showAlert: Bool = false
    
    var cornerRadius: CGFloat = 10
    var shadowRadius: CGFloat = 10
    
    var content: AnyView
    var buttonStack: [Alert.Button]
    
    var animation: AnyTransition = AnyTransition.scale(scale: 1.2).combined(with: .opacity).animation(.easeOut(duration: 0.15))
    
    public init(content: @escaping () -> AnyView, leadingButton: Alert.Button, trailingButton: Alert.Button) {
        self.content = content()
        self.buttonStack = [leadingButton, trailingButton]
    }

    public init(icon: ButtonIcon, color: Color, message: String) {
        self.content = AnyView(
            VStack {
                VSpacer(48)
                Image(icon.rawValue).templateImage(width: 20, color)
                VSpacer(20)
                Text(message).notoSans(.bold, size: 15, color).padding(.bottom, 40)
            }
        )
        self.buttonStack = [
            Alert.Button.center("확인", color: color)
        ]
    }
    
    public static func logoutCheck() -> Alert {
        return Alert(content: {
            AnyView(
                VStack {
                    VSpacer(48)
                    Image("logout").templateImage(width: 20, Color.accent)
                    VSpacer(20)
                    Text("정말 로그아웃 하시겠습니까?").notoSans(.bold, size: 15, Color.text).padding(.bottom, 40)
                }
            )
        },
        leadingButton: Alert.Button(label: "취소", color: Color.gray4, position: .leading),
        trailingButton: Alert.Button(label: "확인", color: Color.accent, position: .trailing, action: {
            print("logout")
//            api.logout
        }))
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
            if showAlert {
                GeometryReader { geometry in
                    ZStack {
                        VStack {
                            Spacer()
                            VStack(spacing: 0) {
                                content
                                HStack(spacing: 0) {
                                    ForEach(0...buttonStack.count-1, id: \.self) {
                                        self.buttonStack[$0]
                                    }
                                }
                            }
                            .background(
                                Rectangle()
                                    .frame(maxWidth: .infinity-40, minHeight: 0, maxHeight: .infinity, alignment: .center)
                                    .foregroundColor(Color.systemBackground)
                                    .cornerRadius(10)
                            )
                            .frame(minWidth: 0, maxWidth: geometry.size.width-40, alignment: .center)
                            .horizonPadding()
                            Spacer()
                        }
                        
                    }
                }.frame(alignment: .center)
                .transition(animation)
            }
        }.onAppear {
            withAnimation {
                self.showAlert = true
            }
        }
        
    }
}




//enum AlertType {
//    case success
//    case warning
//    case danger
//    case cancel
//    case text
//    case logout
//    case idCardReadme
//    case attendance
//    case manageAttendance
//}
//
//class AlertManager: ObservableObject {
//    @Published var isShowing: Bool = false
//    var alertType: AlertType = .warning
//    var content: String = "content"
//    var sub: String = ""
//
//    func createAlert(_ content: String, sub: String, _ alertType: AlertType) {
//        self.alertType = alertType
//        self.content = content
//        self.sub = sub
//        showAlert()
//        print("Alert presented \(content) : \(sub)")
//    }
//
//    func createAlert(_ content: String, _ alertType: AlertType) {
//        self.alertType = alertType
//        self.content = content
//        self.sub = ""
//        showAlert()
//        print("Alert presented \(content) : \(sub)")
//    }
//
//    func logoutCheck() {
//        self.alertType = .logout
//        self.content = "정말 로그아웃 하시겠습니까?"
//        showAlert()
//        print("Alert presented \(content)")
//    }
//    func idCardReadme() {
//        self.alertType = .idCardReadme
//        showAlert()
//    }
//    func attendance() {
//        self.alertType = .attendance
//        showAlert()
//    }
//    func manageAttendance() {
//        self.alertType = .manageAttendance
//        showAlert()
//    }
//    func showAlert() {
//        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
//        withAnimation(.easeInOut(duration: 0.25)) {
//            self.isShowing = true
//        }
//    }
//    func dismiss() {
//        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
//        withAnimation(.easeInOut(duration: 0.25)) {
//            self.isShowing = false
//        }
//    }
//    func getAccentColor() -> Color {
//        switch alertType {
//        case .cancel: return Color("gray4")
//        case .success: return Color("accent")
//        case .warning: return Color("yellow")
//        case .danger: return Color("red")
//        case .text: return Color("accent")
//        case .logout: return Color("accent")
//        case .idCardReadme: return Color("gray4")
//        case .attendance: return Color("accent")
//        case .manageAttendance: return Color.accent
//
//        }
//    }
//
//    func getIconName() -> String {
//        switch alertType {
//        case .cancel: return "disabled-checkmark"
//        case .success: return "checkmark"
//        case .warning: return "warningmark"
//        case .danger: return "dangermark"
//        case .text: return ""
//        case .logout: return "logout"
//        case .idCardReadme: return ""
//        case .attendance: return ""
//        case .manageAttendance: return ""
//        }
//    }
//
//    func getTitleColor() -> Color {
//        if alertType == .success {
//            return Color("accent")
//        }
//        if alertType == .logout {
//            return Color.text
//        } else {
//            return Color("gray4")
//        }
//    }
//}
