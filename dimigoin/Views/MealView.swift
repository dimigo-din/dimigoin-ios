//
//  MealView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct MealView: View {
    @EnvironmentObject var mealAPI: MealAPI
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                     VStack{
                        HStack {
                            VStack(alignment: .leading, spacing: 0){
                                Text(NSLocalizedString(getDateString(), comment: "")).subTitle()
                                Text(NSLocalizedString("오늘의 급식", comment: "")).title()
                            }
                            Spacer()
                            NavigationLink(destination: WeeklyMealView().environmentObject(mealAPI)) {
                                Image("calendar.fill").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(height: 35).foregroundColor(Color.accent)
                            }
                        }.horizonPadding()
                        .padding(.top, 30)
                        HDivider().horizonPadding().offset(y: -15)
                        VStack {
                            SectionHeader("아침", sub: "오전 7시 30분")
//                            Text(mealAPI.getTodayMeal().breakfast)
                            Text(dummyMeal.breakfast)
                                .mealMenu()
                                .padding()
                                .frame(width: abs(geometry.size.width-40), alignment: .leading)
                                .background(CustomBox())
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        VSpacer(20)
                        VStack {
                            SectionHeader("점심", sub: "오후 12시 50분")
//                            Text(mealAPI.getTodayMeal().lunch)
                            Text(dummyMeal.lunch)
                                .mealMenu()
                                .padding()
                                .frame(width: abs(geometry.size.width-40), alignment: .leading)
                                .background(CustomBox())
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        VSpacer(20)
                        VStack {
                            SectionHeader("저녁", sub: "오후 6시 35분")
//                            Text(mealAPI.getTodayMeal().dinner)
                            Text(dummyMeal.dinner)
                                .mealMenu()
                                .padding()
                                .frame(width: abs(geometry.size.width-40), alignment: .leading)
                                .background(CustomBox())
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    VSpacer(20)
                }
            }
            .navigationBarTitle("오늘의 급식")
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

