//
//  MealListView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct MealListView: View {
    @ObservedObject var mealAPI: MealAPI
    @State var day = getIntDay()
    var body: some View {
        
        ScrollView {
            VStack(spacing: 15.0) {
                Picker(selection: $day, label: Text("요일을 선택하세요")) {
                    Text("월").tag(1)
                    Text("화").tag(2)
                    Text("수").tag(3)
                    Text("목").tag(4)
                    Text("금").tag(5)
                    Text("토").tag(6)
                    Text("일").tag(7)
                }.pickerStyle(SegmentedPickerStyle())
                VStack(alignment: .leading, spacing: 10.0) {
                    MealItem(weekday: $day, mealType: .breakfast, mealAPI: mealAPI)
                    MealItem(weekday: $day, mealType: .lunch, mealAPI: mealAPI)
                    MealItem(weekday: $day, mealType: .dinner, mealAPI: mealAPI)
                }
                Divider()
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("정보").font(.headline)
                    Text("식단 정보는 학교 홈페이지 파싱을 통해 제공되는 정보이므로 급식실의 업로드 여부에 따라 식단이 간헐적으로 표시되지 않을 수 있습니다.")
                        .caption2()
                }
                Spacer()
            }.padding()
        }
        .navigationBarTitle(getIntDay() == day ? "오늘의 급식" : "\(getDay(day))요일 급식")
        
        
    }
}

//struct MealListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MealListView()
//    }
//}
