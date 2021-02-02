//
//  NextMealWidget.swift
//  WidgetExtension
//
//  Created by 변경민 on 2020/10/21.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct NextMealWidget: View {
    var data: WidgetEntry
    var body: some View {
        ZStack {
            Image("logo").templateImage(width: 60, Color.accent).opacity(0.25)
            GeometryReader { geometry in
                Rectangle().fill(Color.accent).frame(width: 4, height: geometry.size.height)
            }
            VStack {
                HStack {
                    switch getMealType() {
                    case .breakfast : Text("아침").notoSans(.bold, size: 16, Color.accent)
                    case .lunch : Text("점심").notoSans(.bold, size: 16, Color.accent)
                    case .dinner : Text("저녁").notoSans(.bold, size: 16, Color.accent)
                    }
                    Spacer()
                    Text(getDateString()).notoSans(.medium, size: 10, Color.gray4)
                }
                switch getMealType() {
                case .breakfast : Text(data.breakfast).notoSans(.regular, size: 11)
                case .lunch : Text(data.lunch).notoSans(.regular, size: 11)
                case .dinner : Text(data.dinner).notoSans(.regular, size: 11)
                }
            }.padding(.horizontal)
        }
    }
}
