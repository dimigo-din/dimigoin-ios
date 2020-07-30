//
//  MealRow.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct MealRow: View {
    @ObservedObject var mealData: MealAPI

    var currentHour: Int {
        return Calendar.current.component(.hour, from: Date())
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("급식").sectionHeader()
                Spacer()
                NavigationLink(destination: MealListView(mealData: mealData)) {
                    Text("전체 급식 보기")
                }
            }
            
            VSpacer(15)
            
            switch getMealType() {
            case .breakfast: MealItem(mealType: .breakfast, mealData: mealData)
            case .lunch: MealItem(mealType: .lunch, mealData: mealData)
            case .dinner: MealItem(mealType: .dinner, mealData: mealData)
            }
        }
    }
}

//struct MealRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MealRow(dimibob: dummyDimibob)
//            .previewLayout(.sizeThatFits)
//    }
//}
