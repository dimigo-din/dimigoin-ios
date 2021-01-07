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
    var tokenExist: Bool
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
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct Provider : TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        let placeholderEntry = WidgetEntry(date: Date(),
                                      breakfast: dummyMeal.breakfast,
                                      lunch: dummyMeal.lunch,
                                      dinner: dummyMeal.dinner,
                                      tokenExist: true)
        completion(placeholderEntry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        let accessToken: String = UserDefaults(suiteName: "group.com.dimigoin.v3")?.string(forKey: "accessToken") ?? ""
        if(accessToken == "") { // 토큰이 없을 때 API호출 자체를 안하고 그냥 없다고 넘겨버리고 15분마다 새로고침하게 스케쥴
            let date = Date()
            let data = WidgetEntry(date: Date(),
                                   breakfast: "",
                                   lunch: "",
                                   dinner: "",
                                   tokenExist: false)
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: date)
            let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))
            completion(timeline)
        }
        
//      있으면 API호출하고 다음 15분후에 새로고침 하도록 스케쥴
        let headers: HTTPHeaders = ["Authorization":"Bearer \(accessToken)"]
        let endPoint = "/meal/\(getToday8DigitDateString())"
        let method: HTTPMethod = .get
        AF.request(rootURL+endPoint, method: method, encoding: JSONEncoding.default, headers: headers).responseData { response in
            let json = JSON(response.value ?? [])
            let date = Date()
            let data = WidgetEntry(date: Date(),
                                   breakfast: bindingMenus(menu: json["meal"]["breakfast"]),
                                   lunch: bindingMenus(menu: json["meal"]["lunch"]),
                                   dinner: bindingMenus(menu: json["meal"]["dinner"]),
                                   tokenExist: true)
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: date)
            let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))
            completion(timeline)
        }
    }
    
    func placeholder(in context: Context) -> WidgetEntry {
        let placeholderData = WidgetEntry(date: Date(),
                                      breakfast: dummyMeal.breakfast,
                                      lunch: dummyMeal.lunch,
                                      dinner: dummyMeal.dinner,
                                      tokenExist: true)
        return placeholderData
    }
}

struct WidgetView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var data : WidgetEntry
    var body: some View{
        switch widgetFamily {
        case .systemSmall: NextMealWidget(data: data)
        case .systemMedium: DailyMealWidget(data: data)
        case .systemLarge: TimetableWidget(data: data)
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
