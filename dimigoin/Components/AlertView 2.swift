//
//  AlertView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/09.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct AlertView: View {
    @State var alertType: AlertType
    @State var content: String
    @State var sub: String
    @Binding var isShowing: Bool
    
    func getAccentColor(_ alertType: AlertType) -> Color {
        var colorName: String = "purple"
        switch alertType {
            case .cancel: colorName = "Gray4"
            case .success: colorName = "Accent"
            case .warning: colorName = "Yellow"
            case .danger: colorName = "Red"
        }
        return Color(colorName)
    }
    
    func getIconName(_ alertType: AlertType) -> String {
        var iconName: String = ""
        switch alertType {
            case .cancel: iconName = "disabled-checkmark"
            case .success: iconName = "checkmark"
            case .warning: iconName = "warningmark"
            case .danger: iconName = "dangermark"
        }
        return iconName
    }
    
    func dismiss() {
        self.isShowing = false
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .opacity(0.2)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    dismiss()
                }
            VStack {
                VSpacer(10)
                Image(getIconName(alertType)).resizable().aspectRatio(contentMode: .fit).frame(width: 38).padding(.top)
                VSpacer(20)
                Text(content).alertTitle(getAccentColor(alertType))
                VSpacer(10)
                Text(sub).alertSubTitle().horizonPadding()
                VSpacer(20)
                Divider()
                Button(action: {
                    dismiss()
                }) {
                    Text("확인").alertButton().padding(.bottom).frame(width: 300,height: 40)
                }
            }.frame(width: 300, height: 200)
            .background(
                CustomBox(edgeInsets: .top, accentColor: getAccentColor(alertType), width: 5, tl: 2, tr: 2, bl: 2, br: 2)
            )
        }
    }
}
