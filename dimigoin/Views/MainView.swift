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
                        HStack(spacing: 0) {
                            StudentIdCardView(isShowIdCard: $isShowIdCard)
                                .environmentObject(api)
                            IngangView()
                                .environmentObject(api)
                            HomeView(tapbarIndex: $tapbarIndex)
                                .environmentObject(api)
                            MealView()
                                .environmentObject(api)
                            TimetableView()
                                .environmentObject(api)
                        }.frame(width: geometry.size.width*5)
                        .offset(x: -geometry.size.width*CGFloat(tapbarIndex))
                    }
                    VStack {
                        Spacer()
                        TapBar(index: $tapbarIndex, isShowIdCard: $isShowIdCard, isFetching: $api.isFetching)
                            .offset(x: -geometry.size.width*2)
                            .unredacted()
                    }
                }
            }
        }
    }
}
