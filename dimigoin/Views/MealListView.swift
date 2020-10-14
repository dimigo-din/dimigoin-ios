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
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 15.0) {
                VStack(alignment: .leading, spacing: 10.0) {
                    MealItem(mealType: .breakfast, mealAPI: mealAPI)
                    MealItem(mealType: .lunch, mealAPI: mealAPI)
                    MealItem(mealType: .dinner, mealAPI: mealAPI)
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
        .navigationBarTitle("이번주 급식")
    }
}

//struct MealListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MealListView()
//    }
//}
