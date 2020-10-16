//
//  WeeklyMealView.swift
//  MealWidgetExtension
//
//  Created by 변경민 on 2020/07/25.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TimeTableWidgetView: View {
//    var entry: Entry
    var meal: Dimibob
    var timetable: TimeTable
    var user: User

    @ViewBuilder
    var body: some View {
        ZStack{
            Image("Logo").resizable().frame(width: 120, height: 138).opacity(0.25)
            VStack {
                VStack(alignment: .center) {
                    HStack(alignment: .top) {
                        ForEach((1...5), id: \.self) { day in
                            VStack(alignment: .center){
                                Text("\(getDay(day))").highlight().heavy()
                                Divider().frame(height: 2)
                                ForEach(timetable.data[day-1], id: \.self) { lecture in
                                    Text("\(lecture)").body().padding(.bottom, 5)
                                }
                            }
                        }
                    }
                }.padding()
            }
        }
    }
}
