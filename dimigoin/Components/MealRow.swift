//
//  MealRow.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct MealRow: View {
    @ObservedObject var mealAPI: MealAPI
    @State var day: Int = getIntDay()

    var currentHour: Int {
        return Calendar.current.component(.hour, from: Date())
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("급식").sectionHeader()
                Spacer()
                NavigationLink(destination: MealListView(mealAPI: mealAPI)) {
                    Text("전체 급식 보기").caption1()
                }
            }
            
            VSpacer(15)
            
            switch getMealType() {
            case .breakfast: MealItem(weekday: $day, mealType: .breakfast, mealAPI: mealAPI)
            case .lunch: MealItem(weekday: $day, mealType: .lunch, mealAPI: mealAPI)
            case .dinner: MealItem(weekday: $day, mealType: .dinner,mealAPI: mealAPI)
            }
        }.padding()
    }
}

//struct MealRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MealRow(dimibob: dummyDimibob)
//            .previewLayout(.sizeThatFits)
//    }
//}
