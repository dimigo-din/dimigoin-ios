//
//  MealPreviewView.swift
//  dimigoin
//
//  Created by 변경민 on 2021/03/05.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct MealPreviewView: View {
    @State var breakfast: [String] = []
    @State var lunch: [String] = []
    @State var dinner: [String] = []
    
    init(_ breakfast: [String], _ lunch: [String], _ dinner: [String]) {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = UIColor(Color.accent)
        self._breakfast = .init(wrappedValue: breakfast)
        self._lunch = .init(wrappedValue: lunch)
        self._dinner = .init(wrappedValue: dinner)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    SectionHeader("아침", sub: "오전 7시 30분")
                    Text(bindingMenus(menu: breakfast))
                        .notoSans(.regular, size: 12, Color("gray2"))
                        .padding()
                        .frame(width: abs(geometry.size.width-40), alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .background(Color(UIColor.secondarySystemGroupedBackground).cornerRadius(10).shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0))
                    VSpacer(30)
                    SectionHeader("점심", sub: "오후 12시 50분")
                    Text(bindingMenus(menu: lunch))
                        .notoSans(.regular, size: 12, Color("gray2"))
                        .padding()
                        .frame(width: abs(geometry.size.width-40), alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .background(Color(UIColor.secondarySystemGroupedBackground).cornerRadius(10).shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0))
                    VSpacer(30)
                    SectionHeader("저녁", sub: "오후 6시 35분")
                    Text(bindingMenus(menu: dinner))
                        .notoSans(.regular, size: 12, Color("gray2"))
                        .padding()
                        .frame(width: abs(geometry.size.width-40), alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .background(Color(UIColor.secondarySystemGroupedBackground).cornerRadius(10).shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0))
                }.horizonPadding()
            }
        }
    }
}
