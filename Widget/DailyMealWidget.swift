//
//  DailyMealWidget.swift
//  dimigoin
//
//  Created by 변경민 on 2020/10/21.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct DailyMealWidget: View {
    var data: WidgetEntry
    
    var body: some View {
        ZStack {
            Image("logo").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(width: 60).foregroundColor(Color.accent)
                .opacity(0.25)
            GeometryReader { geometry in
                Rectangle().fill(Color.accent)
                    .frame(width: 4, height: geometry.size.height/3)
                    .offset(y: getMealType() == .lunch ? geometry.size.height/3 : (getMealType() == .dinner ? geometry.size.height*2/3 : 0))
            }
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Text("아침").accent().font(Font.custom("NotoSansKR-Bold", size: 16))
                    Text("\(data.breakfast)").font(Font.custom("NotoSansKR-Regular", size: 10))
                }
                HStack {
                    Text("점심").accent().font(Font.custom("NotoSansKR-Bold", size: 16))
                    Text("\(data.lunch)").font(Font.custom("NotoSansKR-Regular", size: 10))
                }
                HStack {
                    Text("저녁").accent().font(Font.custom("NotoSansKR-Bold", size: 16))
                    Text("\(data.dinner)").font(Font.custom("NotoSansKR-Regular", size: 10))
                }
            }.padding(.horizontal)
        }
    }
}

