//
//  DailyMealWidget.swift
//  dimigoin
//
//  Created by 변경민 on 2020/10/21.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct DailyMealWidget: View {
    var data: WidgetEntry
    var body: some View {
        ZStack {
            Image("Logo").resizable().frame(width: 80, height: 92).opacity(0.25)
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Text("아침").highlight().heavy()
                    Text("\(data.meals.breakfast)").caption3()
                }
                HStack {
                    Text("점심").highlight().heavy()
                    Text("\(data.meals.lunch)").caption3()
                }
                HStack {
                    Text("저녁").highlight().heavy()
                    Text("\(data.meals.dinner)").caption3()
                }
            }.padding(.horizontal)
        }
    }
}

