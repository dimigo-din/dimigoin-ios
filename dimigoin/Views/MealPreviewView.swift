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
    @State var meal: Meal = Meal()
    
    init(_ meal: Meal) {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = UIColor(Color.accent)
        self._meal = .init(wrappedValue: meal)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        Spacer()
                        Image("school").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: .infinity).opacity(0.3)
                    }.ignoresSafeArea(.all)
                    ScrollView {
                        SectionHeader("아침", sub: "오전 7시 30분")
                        Text(meal.getBreakfastString())
                            .notoSans(.regular, size: 12, Color("gray2"))
                            .padding()
                            .frame(width: abs(geometry.size.width-40), alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .background(Color(UIColor.secondarySystemGroupedBackground).cornerRadius(10).shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0))
                        VSpacer(30)
                        SectionHeader("점심", sub: "오후 12시 50분")
                        Text(meal.getLunchString())
                            .notoSans(.regular, size: 12, Color("gray2"))
                            .padding()
                            .frame(width: abs(geometry.size.width-40), alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .background(Color(UIColor.secondarySystemGroupedBackground).cornerRadius(10).shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0))
                        VSpacer(30)
                        SectionHeader("저녁", sub: "오후 6시 35분")
                        Text(meal.getDinnerString())
                            .notoSans(.regular, size: 12, Color("gray2"))
                            .padding()
                            .frame(width: abs(geometry.size.width-40), alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .background(Color(UIColor.secondarySystemGroupedBackground).cornerRadius(10).shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0))
                    }.horizonPadding()
                }
                
            }
        }.navigationBarTitle("미리보기")
    }
}
