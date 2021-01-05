//
//  AlertView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/09.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import Combine

struct AlertView: View {
    @EnvironmentObject var alertManager: AlertManager
    @Binding var isShowing: Bool
    
    func getAccentColor(_ alertType: AlertType) -> Color {
        var colorName: String = "purple"
        switch alertType {
            case .cancel: colorName = "gray4"
            case .success: colorName = "accent"
            case .warning: colorName = "yellow"
            case .danger: colorName = "red"
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
        withAnimation(.spring()) {
            self.isShowing = false
        }
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                HStack(spacing: 0){
                    Spacer()
                    Image(getIconName(alertManager.alertType)).resizable().aspectRatio(contentMode: .fit).frame(width: 32).padding(.leading)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(alertManager.content).alertTitle(getAccentColor(alertManager.alertType))
                        Text(alertManager.sub).alertSubTitle()
                    }
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark").font(Font.system(size: 12, weight: .bold, design: .rounded)).padding(.trailing).foregroundColor(Color.gray)
                    }
                }.frame(width: UIDevice.current.userInterfaceIdiom == .phone ? geometry.size.width - 40 : 380, height: 80)
                .background(
                    CustomBox(edgeInsets: .leading, accentColor: getAccentColor(alertManager.alertType), width: 8, tl: 12, tr: 12, bl: 12, br: 12)
                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                )
                .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .phone ? 20 : (geometry.size.width - 380)/2)
                .offset(y: isShowing ? 0 : -geometry.size.height/4)
            }
        }
    }
}
