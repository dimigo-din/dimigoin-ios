//
//  ContentView.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var tokenAPI = TokenAPI()
    
    var body: some View { // check if token exist
        Group {
            if(tokenAPI.tokenStatus == .exist) {
                MainView(tokenAPI: tokenAPI)
            }
            else if(tokenAPI.tokenStatus == .none) {
                LoginView(tokenAPI: tokenAPI)
            }
        }
    }
}

