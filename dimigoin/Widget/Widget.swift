//
//  Widget.swift
//  Widget
//
//  Created by 변경민 on 2020/10/15.
//  Copyright © 2020 seohun. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
       
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        let entry = SimpleEntry(date: entryDate)
        entries.append(entry)
        

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct WidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    @ObservedObject var userAPI: UserAPI
    @ObservedObject var timetableAPI: TimeTableAPI
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall: NextMealWidgetView(meal: dummyDimibob)
        case .systemMedium:TodayMealWidgetView(meal: dummyDimibob)
        case .systemLarge: TimeTableWidgetView(userAPI: userAPI, timetableAPI: timetableAPI)
        default: Text("Error")
        }
    }
}

@main
struct Widget: SwiftUI.Widget {
    @ObservedObject var userAPI = UserAPI()
    @ObservedObject var timetableAPI = TimeTableAPI()
    let kind: String = "디미고인 위젯"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(userAPI: userAPI, timetableAPI: timetableAPI)
        }
        .configurationDisplayName("디미고인 위젯")
        .description("디미고의 급식을 편리하게 조회하고 시간표를 확인하세요")
    }
}

//struct Widget_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetEntryView()
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
