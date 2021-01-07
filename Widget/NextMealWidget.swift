//
//  NextMealWidget.swift
//  WidgetExtension
//
//  Created by 변경민 on 2020/10/21.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct NextMealWidget: View {
    var data: WidgetEntry
    var body: some View {
        ZStack {
            Image("logo").resizable().aspectRatio(contentMode: .fit).frame(width: 60).opacity(0.25)
            VStack {
                HStack {
                    switch getMealType(){
                    case .breakfast : Text("아침").accent().font(Font.custom("NotoSansKR-Bold", size: 16))
                    case .lunch : Text("점심").accent().font(Font.custom("NotoSansKR-Bold", size: 16))
                    case .dinner : Text("저녁").accent().font(Font.custom("NotoSansKR-Bold", size: 16))
                    }
                    Spacer()
                    Text(getDateString()).font(Font.custom("NotoSansKR-Medium", size: 10)).gray4()
                }
                Text(getMealMenu(meal: data.meals, mealType: getMealType())).font(Font.custom("NotoSansKR-Regular", size: 12))

            }.padding(.horizontal)
        }
        
    }
}

