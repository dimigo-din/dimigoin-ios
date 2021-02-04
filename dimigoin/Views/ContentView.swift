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
        
    }
    init(tapbarIdx: Int) {
        self.tapbarIdx = tapbarIdx
    }
    var body: some View {
        NavigationView {
            Group {
                if api.isLoggedIn {
                    MainView(tapbarIdx: tapbarIdx)
                        .environmentObject(api)
                        .environmentObject(alertManager)
//                    Button(action: {
//                        fatalError()
//                    }) {
//                        Text("error")
//                    }
                } else {
                    LoginView()
                        .environmentObject(api)
                        .environmentObject(alertManager)
                }
            }.edgesIgnoringSafeArea(.bottom)
            .placeholderWhileFetching(isFetching: $api.isFetching)
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}
