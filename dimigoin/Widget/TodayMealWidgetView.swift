//
//  TodayMealView.swift
//  MealWidgetExtension
//
//  Created by 변경민 on 2020/07/25.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TodayMealWidgetView: View {
    var meal: Dimibob
    @ViewBuilder
    var body: some View {
        ZStack{
            Image("Logo").resizable().frame(width: 60, height: 69).opacity(0.25)
            VStack(alignment: .leading, spacing: -15) {
                HStack(alignment: .center, spacing: -5) {
                    Text("아침").heavy().highlight().padding(.leading)
                    Text("\(meal.breakfast)").caption3().padding()
                }
//                .opacity(getMealType() != MealType.breakfast ? 0.3 : 1)
//                .background(Color("Primary").opacity(getMealType() == MealType.breakfast ? 0.2 : 0))

                HStack(alignment: .center, spacing: -5) {
                    Text("점심").highlight().heavy().padding(.leading)
                    Text("\(meal.lunch)").caption3().padding()
                }
//                .opacity(getMealType() != MealType.lunch ? 0.3 : 1)
//                .background(Color("Primary").opacity(getMealType() == MealType.lunch ? 0.2 : 0))

                HStack(alignment: .center, spacing: -5) {
                    Text("저녁").highlight().heavy().padding(.leading)
                    Text("\(meal.dinner)").caption3().padding()
                }
//                .opacity(getMealType() != MealType.dinner ? 0.3 : 1)
//                .background(Color("Primary").opacity(getMealType() == MealType.dinner ? 0.2 : 0))

                VSpacer(15)
            }
        }
    }
}
