//
//  WeeklyMealView.swift
//  MealWidgetExtension
//
//  Created by 변경민 on 2020/07/25.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TimeTableWidgetView: View {
    var entry: Entry
    var meal: Dimibob
    var timetable: TimeTable
    var user: User
    
    @ViewBuilder
    var body: some View {
        ZStack{
            Image("Logo").opacity(0.3)
            VStack() {
                Text("\(user.grade)학년 \(user.klass)반 시간표").highlight().heavy().padding()
                HStack(alignment: .top) {
                    VStack {
                        ForEach((1...7), id: \.self) {
                            Text("\($0)교시").highlight().caption2().padding(.bottom, 7)
                        }
                    }
                    ForEach(timetable.data, id: \.self) { data in
                        VStack {
                            ForEach(data, id: \.self) { lecture in
                                Text("\(lecture)").caption1().padding(.bottom, 5)
                            }
                        }
                    }
                }.multilineTextAlignment(.center)
                
                Divider()
                
                HStack(spacing: 0) {
                    switch getMealType() {
                    case .breakfast: Text("아침").highlight().heavy().padding(.leading)
                    case .lunch: Text("점심").highlight().heavy().padding(.leading)
                    case .dinner: Text("저녁").highlight().heavy().padding(.leading)
                    }
                    Text("\(getMealMenu(meal: dummyDimibob, mealType: getMealType()))").caption2().padding()
                }
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
