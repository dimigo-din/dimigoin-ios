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
    var body: some View {
        Group {
            if(tokenAPI.tokenStatus == .exist) {
                MainView()
            }
            else if(tokenAPI.tokenStatus == .none) {
                LoginView(tokenAPI: tokenAPI)
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
