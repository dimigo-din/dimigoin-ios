//
//  MainView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/26.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import UserNotifications
import DimigoinKit

struct MainView: View {
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var api: DimigoinAPI
    @State var tapbarIndex = 2
    @State var dragOffset = CGSize.zero
    @State var isShowIdCard: Bool = false
    
    var body: some View {
        ZStack {
            if tapbarIndex != 2 {
                VStack {
                    Spacer()
                    Image("school").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: .infinity).opacity(0.3)
                    VSpacer(tabBarSize)
                }
            }
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        HStack(spacing: 0){
                            StudentIdCardView(isShowIdCard: $isShowIdCard)
                                .environmentObject(alertManager)
                                .environmentObject(api)
                            IngangView()
                                .environmentObject(alertManager)
                                .environmentObject(api)
                            HomeView(tapbarIndex: $tapbarIndex)
                                .environmentObject(alertManager)
                                .environmentObject(api)
                            MealView()
                                .environmentObject(api)
                            TimetableView()
                                .environmentObject(api)
                        }.frame(width: geometry.size.width*5)
                        .offset(x: -geometry.size.width*CGFloat(tapbarIndex))
                    }.blur(radius: alertManager.isShowing ? 2 : 0)
                    VStack {
                        Spacer()
                        TapBar(index: $tapbarIndex, isShowIdCard: $isShowIdCard)
                            .offset(x: -geometry.size.width*2)
                            .blur(radius: alertManager.isShowing ? 2 : 0)
                    }
                    Color.black.edgesIgnoringSafeArea(.all).opacity(alertManager.isShowing ? 0.1 : 0)
                    AlertView(isShowing: $alertManager.isShowing)
                        .environmentObject(alertManager)
                        .environmentObject(api)
                        .frame(width: geometry.size.width)
                        .offset(x: -geometry.size.width*2)
                }
            }
        }
    }
    func nextPage() {
        if tapbarIndex != 4 {
            self.tapbarIndex += 1
        }
        
    }
    func previousPage() {
        if tapbarIndex != 0 {
            self.tapbarIndex -= 1
        }
    }
}
