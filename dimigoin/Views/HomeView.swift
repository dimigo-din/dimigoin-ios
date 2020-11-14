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
    @ObservedObject var userAPI: UserAPI
    @Binding var showIdCard: Bool
    @State var currentLocation = 0
    @State var currentCardIdx = 0
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                ZStack {
                    VStack {
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            VSpacer(70)
                        } else {
                            VSpacer(20)
                        }
                        Image("School").resizable().aspectRatio(contentMode: .fit).frame(width: UIScreen.screenWidth).opacity(0.3)
                    }
                    HStack {
                        Image("Logo").resizable().aspectRatio(contentMode: .fit).frame(height: 38)
                        Spacer()
                        Button(action: {
                            showIdCard.toggle()
                        }) {
                            // MARK: replace userPhoto-sample to userImage when backend ready
                            Image("userPhoto-sample")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 38)
                                .clipShape(Circle())
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
                MealPagerView(mealAPI: mealAPI, currentCardIdx: $currentCardIdx)
            }
        }
    }
}


