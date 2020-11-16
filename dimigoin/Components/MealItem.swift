//
//  RoundedCorners.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct MealItem: View {
    var content: String
    var mealType: String
    var sub: String
    init(_ mealType: String,_ sub: String, _ content: String) {
        self.content = content
        self.mealType = mealType
        self.sub = sub
    }
    var body: some View {
        VStack {
            SectionHeader(self.mealType, sub: self.sub)
            Text(self.content)
                .mealMenu()
                .padding()
                .frame(width: UIScreen.screenWidth-40)
                .background(CustomBox())
                .fixedSize(horizontal: false, vertical: true)
                
        }
    }
}


