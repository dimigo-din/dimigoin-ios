//
//  MealCardView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/14.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct MealCardView: View {
    @ObservedObject var mealAPI: MealAPI
    @Binding var currentCardIdx: Int
    var body: some View {
        VStack {
            PagerView(pageCount: 3, currentIndex: $currentCardIdx) {
                VStack(alignment: .leading){
                    Text("아침").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color("Accent")).horizonPadding()
                    VSpacer(10)
                    Text("\(mealAPI.getTodayMeal().breakfast)").mealMenu().horizonPadding()
                }.modifier(CardViewModifier(305,147))
                VStack(alignment: .leading) {
                    Text("점심").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color("Accent")).horizonPadding()
                    VSpacer(10)
                    Text("\(mealAPI.getTodayMeal().lunch)").mealMenu().horizonPadding()
                }.modifier(CardViewModifier(305,147))
                VStack(alignment: .leading) {
                    Text("저녁").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color("Accent")).horizonPadding()
                    VSpacer(10)
                    Text("\(mealAPI.getTodayMeal().dinner)").mealMenu().horizonPadding()
                }.modifier(CardViewModifier(305,147))
            }
            VSpacer(145)
            HStack(spacing: 5){
                Circle().frame(width: 8, height: 8).foregroundColor(Color(currentCardIdx == 0 ? "Accent" : "Gray8"))
                Circle().frame(width: 8, height: 8).foregroundColor(Color(currentCardIdx == 1 ? "Accent" : "Gray8"))
                Circle().frame(width: 8, height: 8).foregroundColor(Color(currentCardIdx == 2 ? "Accent" : "Gray8"))
            }
        }
    }
}
