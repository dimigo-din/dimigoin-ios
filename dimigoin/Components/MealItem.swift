//
//  MealItem.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct MealItem: View {
    @Binding var weekday: Int
    @State var mealType: MealType
    @ObservedObject var mealAPI: MealAPI
    
    var body: some View {
        VStack(alignment: .leading) {
            switch mealType {
                case .breakfast: Text("아침").highlight().headline()
                case .lunch: Text("점심").highlight().headline()
                case .dinner: Text("저녁").highlight().headline()
            }
            VSpacer(10)
            switch mealType {
            case .breakfast: Text(self.mealAPI.meals[weekday-1].breakfast).body().lineSpacing(5)
                case .lunch: Text(self.mealAPI.meals[weekday-1].lunch).body().lineSpacing(5)
                case .dinner: Text(self.mealAPI.meals[weekday-1].dinner).body().lineSpacing(5)
            }
            
        }.CustomBox()
    }
}

//struct MealItem_Previews: PreviewProvider {
//    static var previews: some View {
//        MealItem(
//            mealType: .breakfast,
//            mealContent: "훈제오리통마늘구이 | 차조밥 | 쌀밥 | 된장찌개 | 타코야끼 | 쌈무&머스타드 | 포기김치 | 아이스티"
//        )
//            .padding()
//            .previewLayout(.sizeThatFits)
//    }
//}
