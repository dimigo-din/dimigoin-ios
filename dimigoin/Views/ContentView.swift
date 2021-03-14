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
//    @ObservedObject var api = DimigoinAPI()
    
//    var alertManager = AlertManager()
    var tapbarIdx = 2
    init() {
        if needsUpdate() {
//            alertManager.createAlert("최신버전으로 업데이트 해주세요!", .warning)
        }
    }
    @State var showAlert: Bool = false
    var body: some View {
        VStack {
            Button(action: {
                self.showAlert.toggle()
                
            }) {
                Text("hello")
            }
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("alertMain"),
                      content: Text("content"),
                      trailingButton: Alert.Button(label: "확인", type: .cancel, position: .trailing),
                      leadingButton: Alert.Button(label: "취소", type: .default, position: .leading))
            })
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
