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
    
    init() {
        if needsUpdate() {
            Alert.updateRequired()
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if api.isLoggedIn {
                    if api.user.type == .teacher {
                        if api.user.username == "aramark" {
                            MealRegisterView()
                                .environmentObject(api)
                                .placeholderWhileFetching(isFetching: $api.isFetching)
                        } else {
                            TeacherView()
                                .environmentObject(api)
                                .placeholderWhileFetching(isFetching: $api.isFetching)
                        }
                    } else {
                        MainView()
                            .environmentObject(api)
                            .placeholderWhileFetching(isFetching: $api.isFetching)
                    }
                } else {
                    LoginView()
                        .environmentObject(api)
                }
            }.edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
