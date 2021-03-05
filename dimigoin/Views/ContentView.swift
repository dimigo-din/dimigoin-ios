//
//  ContentView.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct ContentView: View {
    @ObservedObject var api = DimigoinAPI()
    
    var alertManager = AlertManager()
    var tapbarIdx = 2
    init() {
        if needsUpdate() {
            alertManager.createAlert("최신버전으로 업데이트 해주세요!", .warning)
        }
    }
    var body: some View {
        NavigationView {
            Group {
                if api.isLoggedIn {
//                    MealRegisterView()
//                        .environmentObject(api)
                    if api.user.type == .teacher {
                        TeacherView()
                            .environmentObject(api)
                            .placeholderWhileFetching(isFetching: $api.isFetching)
                    } else if api.user.type == .aramark {
                        MealRegisterView()
                            .environmentObject(api)
                    } else {
                        MainView(tapbarIdx: tapbarIdx)
                            .environmentObject(api)
                            .environmentObject(alertManager)
                            .placeholderWhileFetching(isFetching: $api.isFetching)
                    }
                } else {
                    LoginView()
                        .environmentObject(api)
                        .environmentObject(alertManager)
                }
            }.edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}
