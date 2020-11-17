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
    @State var tapbarIndex = 2
    @State var showIdCard = false
    
    var body: some View {
        ZStack {
            VStack {
                switch self.tapbarIndex {
                    case 0: ProfileView()
                        .environmentObject(alertManager)
                        .environmentObject(tokenAPI)
                        .environmentObject(userAPI)
                    case 1: IngangView()
                        .environmentObject(alertManager)
                        .environmentObject(tokenAPI)
                        .environmentObject(ingangAPI)
                    case 2: HomeView(showIdCard: $showIdCard)
                        .environmentObject(mealAPI)
                        .environmentObject(alertManager)
                        .environmentObject(tokenAPI)
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
            StudentIdCardModalView(isShowing: $showIdCard)
                .environmentObject(userAPI)
            if(alertManager.isShowing) {
                AlertView(alertType: alertManager.alertType,
                          content: alertManager.content,
                          sub: alertManager.sub,
                          isShowing: $alertManager.isShowing)
            }
        }
    }
}


