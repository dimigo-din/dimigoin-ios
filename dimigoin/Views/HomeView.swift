//
//  HomeView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var mealAPI: MealAPI
    @ObservedObject var alertManager: AlertManager
    @ObservedObject var tokenAPI : TokenAPI
    @State var currentLocation = 0
    @State var currentCardIdx = 0
    init(mealAPI: MealAPI, alertManager: AlertManager, tokenAPI : TokenAPI) {
        self.mealAPI = mealAPI
        self.alertManager = alertManager
        self.tokenAPI = tokenAPI
    }
    
    var body: some View {
        ScrollView(showsIndicators: false){
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
                Spacer()
                Text("오늘의 급식").font(Font.custom("NotoSansKR-Bold", size: 20)).horizonPadding()
                MealCardView(mealAPI: mealAPI, currentCardIdx: $currentCardIdx)
            }
        }
    }
}


