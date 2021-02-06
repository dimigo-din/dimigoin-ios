//
//  WeeklyMealView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/13.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct WeeklyMealView: View {
    @EnvironmentObject var api: DimigoinAPI
    @State var selection: Int = getTodayDayOfWeekInt()-1
    @State var dragOffset = CGSize.zero
    private let days: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    
    init() {
        _ = UINavigationBarAppearance()
        UINavigationBar.appearance().tintColor = UIColor(Color.accent)
    }
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                Picker("요일", selection: $selection) {
                    ForEach(0 ..< days.count) { index in
                        Text(self.days[index]).tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                .frame(width: geometry.size.width-40)
                .offset(x: -geometry.size.width*3)
                HStack(spacing: 0) {
                    ForEach(1...7, id: \.self) { _ in
                        VStack {
                           SectionHeader("아침", sub: "오전 7시 30분")
                           Text(api.meals[selection].breakfast)
                            .notoSans(.regular, size: 12, Color("gray2"))
                               .padding()
                               .frame(width: abs(geometry.size.width-40), alignment: .leading)
                               .background(CustomBox())
                               .fixedSize(horizontal: false, vertical: true)
                           VSpacer(20)
                           SectionHeader("점심", sub: "오후 12시 50분")
                           Text(api.meals[selection].lunch)
                                .notoSans(.regular, size: 12, Color("gray2"))
                               .padding()
                               .frame(width: abs(geometry.size.width-40), alignment: .leading)
                               .background(CustomBox())
                               .fixedSize(horizontal: false, vertical: true)
                           VSpacer(20)
                           SectionHeader("저녁", sub: "오후 6시 35분")
                           Text(api.meals[selection].dinner)
                            .notoSans(.regular, size: 12, Color("gray2"))
                               .padding()
                               .frame(width: abs(geometry.size.width-40), alignment: .leading)
                               .background(CustomBox())
                               .fixedSize(horizontal: false, vertical: true)
                        }.frame(width: geometry.size.width)
                    }
                }
                .animation(.interactiveSpring())
                .offset(x: -geometry.size.width*CGFloat((selection)))
            }
            .navigationBarTitle("이번주 급식")
        }

    }
}
