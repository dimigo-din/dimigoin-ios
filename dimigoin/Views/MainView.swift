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
            VStack(spacing: 0) {
                ZStack {
                    if self.index == 0 {
                        AssignView()
                    }
                    else if self.index == 1 {
                        IngangListView(ingangAPI: ingangAPI, tokenAPI: tokenAPI)
                    }
                    else if self.index == 2 {
                        ScrollView {
                            Text("HomeView")
                        }
                    }
                    else if self.index == 3 {
                        MealListView(mealAPI: mealAPI)
                    }
                    else if self.index == 4 {
                        ScrollView {
                            Button(action: {
                                self.tokenAPI.clearTokens()
                            }) {
                                Text("로그아웃")
                            }
                            
                        }
                    }
                }
                TapBar(index: self.$index)
            }
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}


