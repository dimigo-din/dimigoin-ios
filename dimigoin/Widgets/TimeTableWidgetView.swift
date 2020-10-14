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
            VStack {
                Text("2학년 4반 시간표")
                TimetableItem(timetable: timetable)
            }
        }
    }
}
