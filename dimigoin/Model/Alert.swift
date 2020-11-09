//
//  Alert.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/09.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation
import SwiftUI

enum AlertType: Int {
    case success = 0
    case warning = 1
    case danger = 2
    case cancel = 3
}

class AlertManager: ObservableObject {
    @Published var isShowing: Bool = false
    @Published var alertType: AlertType = .warning
    @Published var content: String = "content"
    @Published var sub: String = "sub"
    
    func present(_ content: String, sub: String, _ type: AlertType) {
        self.alertType = type
        self.content = content
        self.sub = sub
        withAnimation(.spring()) {
            self.isShowing = true
        }
    }
    func dismiss() {
        self.isShowing = false
    }
    var alertView: some View {
        AlertView(alertType: .cancel, content: content, sub: sub)
            .onTapGesture {
                withAnimation() {
                    self.isShowing = false
                }
            }
    }
}

struct AlertView: View {
    @State var alertType: AlertType
    @State var content: String
    @State var sub: String
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .opacity(0.2)
                
            VStack {
                VSpacer(10)
                switch alertType {
                case .cancel:
                    Image("checkmark").resizable().aspectRatio(contentMode: .fit).frame(width: 38).padding(.top)
                    VSpacer(20)
                    Text(content).alertTitle(Color("Gray4"))
                case .success:
                    Image("checkmark").resizable().aspectRatio(contentMode: .fit).frame(width: 38).padding(.top)
                    VSpacer(20)
                    Text(content).alertTitle(Color("Accent"))
                case .warning:
                    Image("warningmark").resizable().aspectRatio(contentMode: .fit).frame(width: 38).padding(.top)
                    VSpacer(20)
                    Text(content).alertTitle(Color("Yellow"))
                case .danger:
                    Image("dangermark").resizable().aspectRatio(contentMode: .fit).frame(width: 38).padding(.top)
                    VSpacer(20)
                    Text(content).alertTitle(Color("Red"))
                }
                
                VSpacer(10)
                Text(sub).alertSubTitle().horizonPadding()
                VSpacer(20)
                Divider()
                Button(action: {
                }) {
                    Text("확인").alertButton().padding(.bottom)
                        
                }
            }.frame(width: 300, height: 200)
            .background(
                CustomBox(edgeInsets: .top, accentColor: Color("Gray4"), width: 5, tl: 2, tr: 2, bl: 2, br: 2)
//                case .success:
//                    CustomBox(edgeInsets: .top, accentColor: Color("Accent"), width: 5, tl: 2, tr: 2, bl: 2, br: 2)
//                case .warning:
//                    CustomBox(edgeInsets: .top, accentColor: Color("Yellow"), width: 5, tl: 2, tr: 2, bl: 2, br: 2)
//                case .danger:
//                    CustomBox(edgeInsets: .top, accentColor: Color("Red"), width: 5, tl: 2, tr: 2, bl: 2, br: 2)
//                }
            )
        }
    }
}
