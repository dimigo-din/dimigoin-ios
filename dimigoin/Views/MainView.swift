//
//  MainView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/26.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var mealAPI: MealAPI
    @ObservedObject var noticeAPI = NoticeAPI()
    @ObservedObject var tokenAPI: TokenAPI
    @ObservedObject var ingangAPI = IngangAPI()
    @ObservedObject var userAPI = UserAPI()
    @State var showProfile = false
    @State var meals: [Dimibob] = []
    
    init(tokenAPI: TokenAPI, mealAPI: MealAPI) {
        self.tokenAPI = tokenAPI
        self.mealAPI = mealAPI
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                TimetableRow(timetable: dummyTimeTable)
                NoticeRow(noticeAPI: noticeAPI)
                MealRow(mealAPI: mealAPI)
                if(ingangAPI.ingangs.count != 0) {
                    IngangRow(ingangAPI: ingangAPI, tokenAPI: tokenAPI)
                } else {
                    Text("오늘은 인강이 없습니다!").body().opacity(0.4).padding()
                }
                CopyrightText()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle(Text(getDate()))
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: ProfileView(tokenAPI: tokenAPI, userAPI: userAPI)) {
                        Image(systemName: userAPI.user.photo)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
