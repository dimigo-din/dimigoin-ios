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
    var meals : Dimibob
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
        .configurationDisplayName("디미고인 급식 위젯")
        .description("간편하고 빠르게 급식을 확인하세요.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct Provider : TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        let loadingData = WidgetEntry(date: Date(), meals: dummyDimibob)
        completion(loadingData)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        let url = "https://api.dimigo.in/dimibobs/\(getFormattedDate())"
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseData { response in
            let json = JSON(response.value!)
            let date = Date()
            let data = WidgetEntry(date: Date(),
                                   meals: Dimibob(breakfast: json["breakfast"].string!,
                                                 lunch: json["lunch"].string!,
                                                 dinner: json["dinner"].string!))
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: date)
            let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))
            completion(timeline)
        }
    }
    
    func placeholder(in context: Context) -> WidgetEntry {
        let loadingData = WidgetEntry(date: Date(), meals: dummyDimibob)
        return loadingData
    }
}

struct WidgetView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var data : WidgetEntry
    var body: some View{
        switch widgetFamily {
        case .systemSmall: NextMealWidget(data: data)
        case .systemMedium: DailyMealWidget(data: data)
        case .systemLarge: Text("Not supported yet")
        default: Text("error")
        }
    }
}
