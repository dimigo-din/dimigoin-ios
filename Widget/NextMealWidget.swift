//
//  NextMealWidget.swift
//  WidgetExtension
//
//  Created by 변경민 on 2020/10/21.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct NextMealWidget: View {
    var data: WidgetEntry
    var body: some View {
        ZStack {
            Image("Logo").resizable().frame(width: 60, height: 69).opacity(0.25)
            VStack {
                HStack {
                    switch getMealType(){
                    case .breakfast : Text("아침").accent().heavy()
                    case .lunch : Text("점심").accent().heavy()
                    case .dinner : Text("저녁").accent().heavy()
                    }
                    Spacer()
                    Text(getDate()).foregroundColor(Color("HelperMessage")).font(Font.custom("NanumSquareR", size: 10))
                }
                Text(getMealMenu(meal: data.meals, mealType: getMealType())).caption2()

            }.padding(.horizontal)
        }
        
    }
}

