//
//  MealRow.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct MealRow: View {
    @State var dimibob: Dimibob

    var currentHour: Int {
        return Calendar.current.component(.hour, from: Date())
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("급식")
                    .font(.headline)
                Spacer()
                NavigationLink(destination: MealListView()) {
                    Text("전체 급식 보기")
                }
            }
            
            Spacer().frame(height: 15.0)
            
            if currentHour < 8 {
                MealItem(mealType: "아침", mealContent: self.dimibob.breakfast)
            } else if currentHour < 13 {
                MealItem(mealType: "점심", mealContent: self.dimibob.lunch)
            } else {
                MealItem(mealType: "저녁", mealContent: self.dimibob.dinner)
            }
        }
    }
}

struct MealRow_Previews: PreviewProvider {
    static var previews: some View {
        MealRow(dimibob: dummyDimibob)
            .previewLayout(.sizeThatFits)
    }
}
