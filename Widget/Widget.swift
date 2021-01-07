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
        let loadingData = WidgetEntry(date: Date(), meals: dummyMeal)
        completion(loadingData)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        let accessToken: String = UserDefaults(suiteName: "group.com.dimigoin.v3")?.string(forKey: "accessToken") ?? ""
        if(accessToken == "") {
            let date = Date()
            let data = WidgetEntry(date: Date(),
                                   meals: Dimibob(breakfast: "위젯을 사용하시려면 앱을 먼저 실행해주세요.",
                                                 lunch: "위젯을 사용하시려면 앱을 먼저 실행해주세요.",
                                                 dinner: "위젯을 사용하시려면 앱을 먼저 실행해주세요."))
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: date)
            let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))
            completion(timeline)
        }
        let headers: HTTPHeaders = [
            "Authorization":"Bearer \(accessToken)"
        ]
        let endPoint = "/meal/\(getToday8DigitDateString())"
        let method: HTTPMethod = .get
        AF.request(rootURL+endPoint, method: method, encoding: JSONEncoding.default, headers: headers).responseData { response in
            let json = JSON(response.value ?? [])
            let date = Date()
            let data = WidgetEntry(date: Date(),
                                   meals: Dimibob(breakfast: bindingMenus(menu: json["meal"]["breakfast"]),
                                                 lunch: bindingMenus(menu: json["meal"]["lunch"]),
                                                 dinner: bindingMenus(menu: json["meal"]["dinner"])))
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: date)
            let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))
            completion(timeline)
        }
    }
    
    func placeholder(in context: Context) -> WidgetEntry {
        let loadingData = WidgetEntry(date: Date(), meals: dummyMeal)
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

extension UserDefaults {
    /// Shared app group(group.com.dimigoin.v3)
    static var shared: UserDefaults {
        let appGroupId = "group.com.dimigoin.v3"
        return UserDefaults(suiteName: appGroupId)!
    }
}
