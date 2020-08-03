//
//  MainView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/26.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var mealData = MealAPI()
    @State var tokenAPI: TokenAPI
    @State var showProfile = false
    @State var meals: [Dimibob] = []
    @State var isLogout: Bool = false
    var body: some View {
        NavigationView {
            ScrollView {
                if getDay() != "토" && getDay() != "일" {
                    TimetableRow(timetable: dummyTimeTable).padding()
                }
                NoticeRow(notices: [dummyNotice1, dummyNotice2]).padding()

                MealRow(mealData: mealData).padding()

                IngangRow(ingangs: [dummyIngang1, dummyIngang2]).padding()
                Spacer()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle(Text(getDate()))
            .navigationBarItems(
                trailing: Button(action: { self.showProfile.toggle() }) {
                    Image(systemName: dummyUser.photo)
                        .resizable()
                        .frame(width: 30, height: 30)
                }.sheet(isPresented: $showProfile) {
                    ProfileView(isPresented: $showProfile, tokenAPI: tokenAPI, user: dummyUser)
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
