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
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry = Entry(date: Date())
    var meal: Dimibob = dummyDimibob
    @ViewBuilder
    var body: some View {
        switch family {
            case .systemSmall: NextMeal(entry: entry, meal: meal)
            case .systemMedium: TodayMeal(entry: entry, meal: meal)
            case .systemLarge: WeekMeal()
        default: Text("meal view is not available")
        }
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
            case .systemMedium: TodayMeal(entry: entry, meal: meal)
            case .systemLarge: WeekMeal()
        default: Text("meal view is not available")
        }
    }
}
