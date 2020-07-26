//
//  NextMealView.swift
//  MealWidgetExtension
//
//  Created by 변경민 on 2020/07/25.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct NextMealWidgetView: View {
    var entry: Provider.Entry
    var meal: Dimibob
    
    @ViewBuilder
    var body: some View {
        ZStack {
            Image("Logo").opacity(0.3)
            VStack(spacing: 3) {
                HStack(alignment: .center) {
                    switch getMealType() {
                        case .breakfast: Text("아침").highlight().bold().padding(.leading)
                        case .lunch: Text("점심").highlight().bold().padding(.leading)
                        case .dinner: Text("저녁").highlight().bold().padding(.leading)
                    }
                    Spacer()
                    Text(getDate()).disabled().caption3().padding(.trailing)
                }
                Text("\(getMealMenu(meal: meal, mealType: getMealType()))").caption2().padding(.leading).padding(.trailing)
                VStack(alignment: .trailing) {
                    Text("LastUpdate:").disabled().caption3()
                    +
                    Text(entry.date, style: .time).disabled().caption3()
                }
            }
        }
    }
}

