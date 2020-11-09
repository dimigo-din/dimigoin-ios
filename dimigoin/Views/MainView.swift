//
//  MainView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/26.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import UserNotifications

struct MainView: View {
    @ObservedObject var mealAPI = MealAPI()
    @ObservedObject var noticeAPI = NoticeAPI()
    @ObservedObject var tokenAPI: TokenAPI
    @ObservedObject var ingangAPI = IngangAPI()
    @ObservedObject var userAPI = UserAPI()
    @ObservedObject var timetableAPI = TimetableAPI()
    @ObservedObject var optionAPI = OptionAPI()
    @ObservedObject var alertManager = AlertManager()
    var NotificationAPI = NotificationManager()
    @State var index = 2
    
    init(tokenAPI: TokenAPI) {
        self.tokenAPI = tokenAPI
        let notificationManager = NotificationManager()
        notificationManager.requestPermission()
        if(optionAPI.beneduAlert) {
            NotificationAPI.scheduleBeneduNotifications()
        } else {
            NotificationAPI.removeAllNotifications()
        }
    }
    var body: some View {
        Group {
            VStack {
                ZStack {
                    switch self.index {
                        case 0: AssignView()
                        case 1: IngangView(ingangAPI: ingangAPI, tokenAPI: tokenAPI)
                        case 2: HomeView(mealAPI: mealAPI)
                        case 3: MealView(mealAPI: mealAPI)
                        case 4: StudentIdCardView(alertManager: alertManager)
                        default: Text("Error")
                    }
                    if(alertManager.isShowing) {
                        alertManager.alertView
                    }
                }
                TapBar(index: self.$index)
            }
        }
    }
}

