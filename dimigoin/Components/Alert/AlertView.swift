//
//  AlertView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/09.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

typealias SystemButton = Button

public struct AlertView: View {
    @State var showAlert: Bool = false
    
    var cornerRadius: CGFloat = 10
    var shadowRadius: CGFloat = 10
    
    var content: AnyView
    var buttonStack: [AlertView.Button]
    
    var animation: AnyTransition = AnyTransition.scale(scale: 1.2).combined(with: .opacity).animation(.easeOut(duration: 0.15))
    
    public init(content: @escaping () -> AnyView, leadingButton: AlertView.Button, trailingButton: AlertView.Button) {
        self.content = content()
        self.buttonStack = [leadingButton, trailingButton]
    }
    
    public init(content: @escaping () -> AnyView, centerButton: AlertView.Button) {
        self.content = content()
        self.buttonStack = [centerButton]
    }
    
    public init(content: @escaping () -> AnyView) {
        self.content = content()
        self.buttonStack = []
    }

    public init(icon: AlertIcon, color: Color, message: String) {
        self.content = AnyView(
            VStack {
                VSpacer(48)
                Image(icon.rawValue).templateImage(width: 20, color)
                VSpacer(20)
                Text(message).notoSans(.bold, size: 15, color).padding(.bottom, 40)
            }
        )
        self.buttonStack = [
            AlertView.Button.center("확인", color: color)
        ]
    }
    
    public enum AlertIcon: String {
        case warningmark = "warningmark"
        case dangermark = "dangermark"
        case checkmark = "checkmark"
        case logoutmark = "logout"
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
                                    if !buttonStack.isEmpty {
                                        ForEach(0...buttonStack.count-1, id: \.self) {
                                            self.buttonStack[$0]
                                        }
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
