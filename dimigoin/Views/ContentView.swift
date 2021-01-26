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
    
    var body: some View {
        Group {
            if(api.isFirstLogin) {
                LoginView()
                    .environmentObject(api)
            }
            else {
                MainView()
                    .environmentObject(api)
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}
