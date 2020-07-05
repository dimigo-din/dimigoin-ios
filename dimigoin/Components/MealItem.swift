//
//  MealItem.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct MealItem: View {
    @State var mealType: String
    @State var mealContent: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.mealType).highlight().headline()
            VSpacer(10)
            Text(self.mealContent)
                .foregroundColor(Color.black).body()
        }.CustomBox()
    }
}

struct MealItem_Previews: PreviewProvider {
    static var previews: some View {
        MealItem(
            mealType: "점심",
            mealContent: "훈제오리통마늘구이 | 차조밥 | 쌀밥 | 된장찌개 | 타코야끼 | 쌈무&머스타드 | 포기김치 | 아이스티"
        )
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
