//
//  TodayMealView.swift
//  MealWidgetExtension
//
//  Created by 변경민 on 2020/07/25.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TodayMeal: View {
    var entry: Entry
    var meal: Dimibob
    @ViewBuilder
    var body: some View {
        ZStack{
            Image("Logo").opacity(0.3)
            VStack(alignment: .leading, spacing: -15) {
//                HStack {
//                    Text("7월 25일 토요일").highlight().headline().padding(.leading)
//                }
                HStack(alignment: .center, spacing: -5) {
                    Text("아침").highlight().bold().padding(.leading)
                    Text("\(meal.breakfast)").caption3().padding()
                }
                HStack(alignment: .center, spacing: -5) {
                    Text("점심").highlight().bold().padding(.leading)
                    Text("\(meal.lunch)").caption3().padding()
                }
                HStack(alignment: .center, spacing: -5) {
                    Text("저녁").highlight().bold().padding(.leading)
                    Text("\(meal.dinner)").caption3().padding()
                }
                
                VSpacer(15)
                HStack() {
                    Spacer()
                    Text("LastUpdate : ").disabled().caption3()
                    +
                    Text(entry.date, style: .time).disabled().caption3()
                }.padding(.trailing, 17)
            }
        }
    }
}
