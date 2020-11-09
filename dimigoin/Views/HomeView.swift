//
//  HomeView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var currentLocation = 0
    @ObservedObject var mealAPI: MealAPI
    init(mealAPI: MealAPI) {
        self.mealAPI = mealAPI
    }
    
    var body: some View {
        ScrollView {
            VStack{
                ZStack {
                    VStack {
                        VSpacer(70)
                        Image("School").resizable().aspectRatio(contentMode: .fit).frame(width: UIScreen.screenWidth).opacity(0.3)
                    }
                    HStack {
                        Image("Logo").resizable().aspectRatio(contentMode: .fit).frame(height: 38)
                        Spacer()
                        Button(action: {
                            // Profile View
                        }) {
                            Circle()
                                .frame(width: 38, height: 38)
                                .foregroundColor(Color.white)
                                .overlay(
                                    Circle().stroke(Color("Accent"), lineWidth: 2)
                                )
                        }
                    }.horizonPadding()
                }
                VSpacer(15)
                LocationSelectionView(currentLocation: $currentLocation)
                Text("오늘의 급식").font(Font.custom("NotoSansKR-Bold", size: 20)).horizonPadding()
            }  // MARK: Chage x offset with formula
            VSpacer(20)
//            HStack(spacing: 15) {
//                VStack(alignment: .leading){
//                    Text("아침").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color("Accent")).horizonPadding()
//                    VSpacer(10)
//                    Text("\(mealAPI.getTodayMeal().breakfast)").mealMenu().horizonPadding()
//                }.modifier(CardViewModifier(305,147))
//                VStack(alignment: .leading) {
//                    Text("점심").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color("Accent")).horizonPadding()
//                    VSpacer(10)
//                    Text("\(mealAPI.getTodayMeal().lunch)").mealMenu().horizonPadding()
//                }.modifier(CardViewModifier(305,147))
//                VStack(alignment: .leading) {
//                    Text("저녁").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color("Accent")).horizonPadding()
//                    VSpacer(10)
//                    Text("\(mealAPI.getTodayMeal().dinner)").mealMenu().horizonPadding()
//                }.modifier(CardViewModifier(305,147))
//            }
//            .modifier(SnapScrollModifier(items: 3, itemWidth: 305, itemSpacing: 15))
        }
    }
}
