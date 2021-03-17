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
//    var alertManager = AlertManager()
    var tapbarIdx = 2
    init() {
        if needsUpdate() {
//            alertManager.createAlert("최신버전으로 업데이트 해주세요!", .warning)
        }
    }
    var body: some View {
        VStack {
            Button(action: {
                Alert.forgetPassword()
            }) {
                Text("forgetPassword")
            }
            Button(action: {
                Alert.present("안녕하세요", icon: .checkmark, color: .accent)
            }) {
                Text("hello")
            }
            Button(action: {
                Alert.present("인강 신청 실패", remark: "어떤 오류가 발생", icon: .checkmark, color: .gray4)
            }) {
                Text("hello")
            }
            Button(action: {
                Alert.readmeBeforeUseIDCard()
            }) {
                Text("readme")
            }
        }
        
//        NavigationView {
//            Group {
//                if api.isLoggedIn {
//                    if api.user.type == .teacher {
//                        if api.user.username == "aramark" {
//                            MealRegisterView()
//                                .environmentObject(api)
////                                .environmentObject(alertManager)
//                                .placeholderWhileFetching(isFetching: $api.isFetching)
//                        } else {
//                            TeacherView()
//                                .environmentObject(api)
//                                .placeholderWhileFetching(isFetching: $api.isFetching)
//                        }
//                    } else {
//                        MainView(tapbarIdx: tapbarIdx)
//                            .environmentObject(api)
////                            .environmentObject(alertManager)
//                            .placeholderWhileFetching(isFetching: $api.isFetching)
//                    }
//                } else {
//                    LoginView()
//                        .environmentObject(api)
////                        .environmentObject(alertManager)
//                }
//            }.edgesIgnoringSafeArea(.bottom)
//            .navigationBarHidden(true)
//        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}
