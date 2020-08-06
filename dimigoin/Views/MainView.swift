//
//  MainView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/26.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var mealData: MealAPI
    @ObservedObject var noticeData = NoticeAPI()
    @ObservedObject var tokenAPI: TokenAPI
    @ObservedObject var ingangAPI = IngangAPI()
    @State var showProfile = false
    @State var meals: [Dimibob] = []
    @State var isLogout: Bool = false
    
    init(tokenAPI: TokenAPI, mealAPI: MealAPI) {
        self.tokenAPI = tokenAPI
        self.mealData = mealAPI
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                if getDay() != "토" && getDay() != "일" {
                    TimetableRow(timetable: dummyTimeTable).padding()
                }
                NoticeRow(noticeData: noticeData).padding()
                MealRow(mealData: mealData).padding()
                IngangRow(ingangData: ingangAPI).padding()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle(Text(getDate()))
            .navigationBarItems(
                trailing: Button(action: { self.showProfile.toggle() }) {
                    Image(systemName: dummyUser.photo)
                        .resizable()
                        .frame(width: 30, height: 30)
                }.sheet(isPresented: $showProfile) {
                    ProfileView(tokenAPI: tokenAPI)
                }
            )
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
