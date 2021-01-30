//
//  Widget.swift
//  Widget
//
//  Created by 변경민 on 2020/10/20.
//  Copyright © 2020 seohun. All rights reserved.
//

import WidgetKit
import SwiftUI
import Alamofire
import SwiftyJSON
import DimigoinKit

struct WidgetEntry : TimelineEntry {
    var date : Date
    var breakfast: String
    var lunch: String
    var dinner: String
}

@main
struct MainWidget : Widget {
    var body: some WidgetConfiguration{
        StaticConfiguration(
            kind: "DimigoinWidget",
            provider: Provider()
        ) { data in
            WidgetView(data: data)
        }
        .configurationDisplayName("디미고인 위젯")
        .description("누구보다 빠르게 급식과 시간표를 확인해보세요")
//        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .supportedFamilies([.systemSmall, .systemMedium])

    }
}

struct Provider : TimelineProvider {
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        getMeal(from: getToday8DigitDateString()) { meal in
            let data = WidgetEntry(date: Date(),
                                    breakfast: meal.breakfast,
                                    lunch: meal.lunch,
                                    dinner: meal.dinner)
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())
            let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))
            completion(timeline)
        }
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        let placeholderEntry = WidgetEntry(date: Date(),
                                      breakfast: sampleMeal.breakfast,
                                      lunch: sampleMeal.lunch,
                                      dinner: sampleMeal.dinner)
        completion(placeholderEntry)
    }
    
    func placeholder(in context: Context) -> WidgetEntry {
        let placeholderData = WidgetEntry(date: Date(),
                                      breakfast: sampleMeal.breakfast,
                                      lunch: sampleMeal.lunch,
                                      dinner: sampleMeal.dinner)
        return placeholderData
    }
}

struct WidgetView : View {
    @Environment(\.widgetFamily) var widgetFamily
    @State var api: DimigoinAPI = DimigoinAPI()

    var data : WidgetEntry
    var body: some View{
        switch widgetFamily {
        case .systemSmall: NextMealWidget(data: data)
        case .systemMedium: DailyMealWidget(data: data)
//        case .systemLarge: TimetableWidget(api: api, data: data)
        default: Text("error")
        }
    }
}

extension UserDefaults {
    /// Shared app group(group.in.dimigo.ios)
    static var shared: UserDefaults {
        let appGroupId = "group.in.dimigo.ios"
        return UserDefaults(suiteName: appGroupId)!
    }
}
