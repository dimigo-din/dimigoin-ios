//
//  MealView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct MealView: View {
    @ObservedObject var mealAPI: MealAPI
    
    init(mealAPI: MealAPI) {
        self.mealAPI = mealAPI
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                HStack {
                    ViewTitle("급식", sub: getDate())
                    Spacer()
                    NavigationLink(destination: WeeklyMealView()) {
                        Image("calender").resizable().aspectRatio(contentMode: .fit).frame(height: 40)
                    }
                }.horizonPadding()
                .padding(.top, 40)
                HDivider().horizonPadding()
                MealItem("아침", "오전 7시 30분", mealAPI.getTodayMeal().breakfast)
                VSpacer(20)
                MealItem("점심", "오전 12시 50분", mealAPI.getTodayMeal().lunch)
                VSpacer(20)
                MealItem("저녁", "오후 6시 35분", mealAPI.getTodayMeal().dinner)
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

extension View {
    func horizonPadding() -> some View {
        self.padding(.leading, 20).padding(.trailing, 20)
    }
    func verticalPadding() -> some View {
        self.padding(.top, 20).padding(.bottom, 20)
    }
}
