//
//  NextMealView.swift
//  MealWidgetExtension
//
//  Created by 변경민 on 2020/07/25.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct NextMealWidgetView: View {
//    var entry: Provider.Entrys
    var meal: Dimibob
    @ViewBuilder
    var body: some View {
        ZStack {
            Image("Logo").resizable().frame(width: 60, height: 69).opacity(0.25)
            VStack(spacing: 3) {
                HStack (alignment:.center){
                    switch getMealType() {
                        case .breakfast: Text("아침").highlight().heavy().padding(.leading)
                        case .lunch: Text("점심").highlight().heavy().padding(.leading)
                        case .dinner: Text("저녁").highlight().heavy().padding(.leading)
                    }
                    Spacer()
                    Text(getDate()).foregroundColor(Color("HelperMessage")).caption3().padding(.trailing)
                }
                Text("\(getMealMenu(meal: meal, mealType: getMealType()))").caption2().padding(.leading).padding(.trailing)
                
            }
        }
    }
}
