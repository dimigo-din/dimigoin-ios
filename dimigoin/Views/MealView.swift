//
//  MealView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct MealView: View {
    @EnvironmentObject var mealAPI: MealAPI
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                HStack {
                    ViewTitle("급식", sub: getDateString())
                    Spacer()
                    NavigationLink(destination: WeeklyMealView()) {
                        Image("calender").resizable().aspectRatio(contentMode: .fit).frame(height: 40)
                    }
                }.horizonPadding()
                .padding(.top, 40)
                HDivider().horizonPadding().offset(y: -15)
                MealItem("아침", "오전 7시 30분", mealAPI.getTodayMeal().breakfast)
                VSpacer(20)
                MealItem("점심", "오후 12시 50분", mealAPI.getTodayMeal().lunch)
                VSpacer(20)
                MealItem("저녁", "오후 6시 35분", mealAPI.getTodayMeal().dinner)
                Spacer()
            }
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

