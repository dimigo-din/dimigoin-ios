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
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
       
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct WidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall: NextMealWidgetView(meal: Dimibob(breakfast: "급식 정보가 없습니다.",
                                                            lunch: "급식 정보가 없습니다.",
                                                            dinner: "급식 정보가 없습니다."))
        case .systemMedium:TodayMealWidgetView(meal: Dimibob(breakfast: "급식 정보가 없습니다.",
                                                             lunch: "급식 정보가 없습니다.",
                                                             dinner: "급식 정보가 없습니다."))
        case .systemLarge: Text("large")
        default: Text("small")
        }
    }
}

@main
struct Widget: SwiftUI.Widget {
    let kind: String = "디미고인 위젯"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView()
        }
        .configurationDisplayName("디미고인 위젯")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
