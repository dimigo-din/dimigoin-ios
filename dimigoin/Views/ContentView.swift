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
    @Namespace var namespace
    
    var alertManager = AlertManager()
    var tapbarIdx = 2
    init() {
        
    }
    init(tapbarIdx: Int) {
        self.tapbarIdx = tapbarIdx
    }
    var body: some View {
        NavigationView {
            Group {
                if api.isLoggedIn {
                    if api.user.type == .teacher {
                        TeacherView()
                            .environmentObject(api)
                    } else {
                        MainView(tapbarIdx: tapbarIdx)
                            .environmentObject(api)
                            .environmentObject(alertManager)
                    }
                } else {
                    LoginView()
                        .matchedGeometryEffect(id: "mainview", in: namespace)
                        .environmentObject(api)
                        .environmentObject(alertManager)
                }
            }.edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}
