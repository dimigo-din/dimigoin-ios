//
//  MealWidget.swift
//  MealWidget
//
//  Created by 변경민 on 2020/07/24.
//  Copyright © 2020 seohun. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    public func snapshot(with context: Context, completion: @escaping (Entry) -> ()) {
        let entry = Entry(date: Date())
        completion(entry)
    }

    public func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let date = Date()
        let entry = Entry(date: Date())
        let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 3, to: date)!
        let timeline = Timeline(
            entries: [entry],
            policy: .after(nextUpdateDate)
        )
        completion(timeline)
    }
}

struct Entry: TimelineEntry {
    public let date: Date
}

struct PlaceholderView : View {
    var body: some View {
        Text("오늘의 급식")
    }
}

@main
struct MealWidget: Widget {
    public var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "com.dimigoin.MealWidget",
            provider: Provider(),
            placeholder: PlaceholderView()
        ) { entry in
            MealWidgetView(entry: entry, meal: dummyDimibob)
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .configurationDisplayName("오늘의 급식")
        .description("오늘의 급식을 알려드립니다")
    }
}

struct MealWidgetView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    var meal: Dimibob
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall: NextMeal(entry: entry, meal: meal)
        case .systemMedium: TodayMeal()
        case .systemLarge: WeekMeal()
        default: Text("meal view is not available")
        }
    }
}

struct NextMeal: View {
    var entry: Provider.Entry
    var meal: Dimibob
    @ViewBuilder
    var body: some View {
        ZStack {
            Image("Logo").opacity(0.3)
            VStack {
                HStack {
                    Text("아침").highlight().bold()
                    Text("\(date)\(day)요일").disabled().caption2()
                }
                Text("\(meal.breakfast)").caption2().padding()
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

struct TodayMeal: View {
    @ViewBuilder
    var body: some View {
        Text("from breakfast to dinner")
    }
}

struct WeekMeal: View {
    @ViewBuilder
    var body: some View {
        Text("it will show the entire meal")
    }
}
