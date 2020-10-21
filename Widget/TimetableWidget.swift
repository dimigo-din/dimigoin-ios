//
//  TimeTableWidget.swift
//  WidgetExtension
//
//  Created by 변경민 on 2020/10/20.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import WidgetKit

@available(iOS 14.0, *)
struct TimetableWidget: View {
    var entry: TimelineEntry
    var timetableAPI: TimetableAPI
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .top) {
                ForEach((1...5), id: \.self) { day in
                    VStack(alignment: .center){
                        Text("\(getDay(day))").highlight().heavy()
                        Divider().frame(height: 2)
                        ForEach(timetableAPI.getTimetable(grade: 2, klass: 4).data[day-1], id: \.self) { lecture in
                            Text("\(lecture)").body().padding(.bottom, 5)
                        }
                    }
                }
            }
            Text("\(entry.date)")
        }
    }
}
