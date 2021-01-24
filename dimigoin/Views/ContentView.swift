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
    @ObservedObject var tokenAPI = TokenAPI()
    var alertManager = AlertManager()
    init() {
        tokenAPI.saveTokens()
    }
    var body: some View { // check if token exist
        Group {
            if(tokenAPI.tokenStatus == .exist) {
                MainView()
                    .environmentObject(tokenAPI)
                    .environmentObject(alertManager)
            }
            else if(tokenAPI.tokenStatus == .none) {
                LoginView()
                    .environmentObject(tokenAPI)
                    .environmentObject(alertManager)
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}
