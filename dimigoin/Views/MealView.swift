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
            ScrollView(showsIndicators: false) {
                GeometryReader { geometry in
                     VStack{
                        HStack {
                            ViewTitle("급식", sub: getDateString())
                            Spacer()
                            NavigationLink(destination: WeeklyMealView().environmentObject(mealAPI)) {
                                Image("calender").resizable().aspectRatio(contentMode: .fit).frame(height: 40)
                            }
                        }.horizonPadding()
                        .padding(.top, 40)
                        HDivider().horizonPadding().offset(y: -15)
                        VStack {
                            SectionHeader("아침", sub: "오전 7시 30분")
                            Text(mealAPI.getTodayMeal().breakfast)
                                .mealMenu()
                                .padding()
                                .frame(width: abs(geometry.size.width-40))
                                .background(CustomBox())
                                .fixedSize(horizontal: false, vertical: true)
                                
                        }
                        VSpacer(20)
                        VStack {
                            SectionHeader("점심", sub: "오후 12시 50분")
                            Text(mealAPI.getTodayMeal().lunch)
                                .mealMenu()
                                .padding()
                                .frame(width: abs(geometry.size.width-40))
                                .background(CustomBox())
                                .fixedSize(horizontal: false, vertical: true)
                                
                        }
                        VSpacer(20)
                        VStack {
                            SectionHeader("저녁", sub: "오후 6시 35분")
                            Text(mealAPI.getTodayMeal().dinner)
                                .mealMenu()
                                .padding()
                                .frame(width: abs(geometry.size.width-40))
                                .background(CustomBox())
                                .fixedSize(horizontal: false, vertical: true)
                                
                        }
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("오늘의 급식")
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

