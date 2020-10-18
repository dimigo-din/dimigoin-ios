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
    @ObservedObject var timetableAPI = TimeTableAPI()
    @State var showProfile = false
    
    init(tokenAPI: TokenAPI, mealAPI: MealAPI) {
        self.tokenAPI = tokenAPI
        self.mealAPI = mealAPI
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                TimetableRow(timetableAPI: timetableAPI, userAPI: userAPI)
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
                leading:
                    Button(action: {
                        mealAPI.getWeeklyMeals()
                        ingangAPI.getTickets()
                        ingangAPI.getApplicantList()
                        ingangAPI.getIngangList()
                        noticeAPI.getNotice()
                    }) {
                        Image(systemName: "arrow.clockwise").font(Font.system(size: 21))
                    },
                trailing:
                    NavigationLink(destination: ProfileView(tokenAPI: tokenAPI, userAPI: userAPI)) {
                        Image(systemName: userAPI.user.photo).font(Font.system(size: 30))
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
