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
    @State var showEscape = false
    
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
        AlertView(.cancel, content: content, sub: sub)
            .onTapGesture {
                withAnimation() {
                    self.isShowing.toggle()
                }
            }
    }
}

struct AlertView: View {
    var type: AlertType
    var content: String
    var sub: String
    init(_ type: AlertType, content: String, sub: String) {
        self.type = type
        self.content = content
        self.sub = sub
    }
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .opacity(0.2)
            VStack {
                VSpacer(10)
                Image("checkmark").resizable().aspectRatio(contentMode: .fit).frame(width: 38).padding(.top)
                VSpacer(20)
                Text(content).alertTitle(Color("Gray4"))
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
            )
        }
    }
}
