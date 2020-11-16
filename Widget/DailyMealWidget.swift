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
            Image("logo").resizable().aspectRatio(contentMode: .fit).frame(width: 80).opacity(0.25)
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Text("아침").accent().font(Font.custom("NotoSansKR-Bold", size: 16))
                    Text("\(data.meals.breakfast)").font(Font.custom("NotoSansKR-Regular", size: 10))
                }
                HStack {
                    Text("점심").accent().font(Font.custom("NotoSansKR-Bold", size: 16))
                    Text("\(data.meals.lunch)").font(Font.custom("NotoSansKR-Regular", size: 10))
                }
                HStack {
                    Text("저녁").accent().font(Font.custom("NotoSansKR-Bold", size: 16))
                    Text("\(data.meals.dinner)").font(Font.custom("NotoSansKR-Regular", size: 10))
                }
            }.padding(.horizontal)
        }
    }
}

