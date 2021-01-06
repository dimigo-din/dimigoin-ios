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
    @EnvironmentObject var tokenAPI: TokenAPI
    @ObservedObject var mealAPI = MealAPI()
    @ObservedObject var noticeAPI = NoticeAPI()
    @ObservedObject var ingangAPI = IngangAPI()
    @ObservedObject var userAPI = UserAPI()
    @ObservedObject var timetableAPI = TimetableAPI()
    @State var tapbarIndex = 1
    @State var isShowIdCard = false
    
    var body: some View {
        ZStack {
            VStack {
                switch self.tapbarIndex {
                    case 0: ProfileView()
                        .environmentObject(tokenAPI)
                        .environmentObject(alertManager)
                        .environmentObject(userAPI)
                    case 1: IngangView()
                        .environmentObject(tokenAPI)
                        .environmentObject(alertManager)
                        .environmentObject(ingangAPI)
                    case 2: HomeView(isShowIdCard: $isShowIdCard)
                        .environmentObject(tokenAPI)
                        .environmentObject(mealAPI)
                        .environmentObject(alertManager)
                        .environmentObject(userAPI)
                    case 3: MealView()
                        .environmentObject(mealAPI)
                    case 4: TimetableView()
                        .environmentObject(timetableAPI)
                        .environmentObject(userAPI)
                    default: Text("Error")
                }
                TapBar(index: self.$tapbarIndex)
            }
            StudentIdCardModalView(isShowing: $isShowIdCard)
                .environmentObject(userAPI)
            AlertView(isShowing: $alertManager.isShowing)
                .environmentObject(alertManager)
            
        }
    }
}
