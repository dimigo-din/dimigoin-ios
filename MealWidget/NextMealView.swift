//
//  NextMealView.swift
//  MealWidgetExtension
//
//  Created by 변경민 on 2020/07/25.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct NextMeal: View {
    var entry: Provider.Entry
    var meal: Dimibob
    @ViewBuilder
    var body: some View {
        ZStack {
            Image("Logo").opacity(0.3)
            VStack(spacing: -15) {
                HStack(alignment: .bottom) {
                    Text("아침").highlight().bold().padding(.leading)
                    Spacer()
                    Text("\(date)\(day)요일").disabled().caption2().padding(.trailing)
                }
                Text("\(meal.breakfast)").caption2().padding()
                VSpacer(15)
                VStack(alignment: .trailing) {
                    Text("LastUpdate:").disabled().caption2()
                    +
                    Text(entry.date, style: .time).disabled().caption2()
                }
            }
        }
    }
    var day: String {
        let now = Date()
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.timeZone = TimeZone(abbreviation: "KST")
        date.dateFormat = "E"
        
        return date.string(from: now)
    }
    
    var date: String {
        let now = Date()
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.timeZone = TimeZone(abbreviation: "KST")
        date.dateFormat = "M월 d일"
        
        return date.string(from: now)
    }
}

