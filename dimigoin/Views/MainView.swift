//
//  MainView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/26.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import UserNotifications
import DimigoinKit

struct MainView: View {
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var tokenAPI: TokenAPI
    @ObservedObject var mealAPI = MealAPI()
    @ObservedObject var noticeAPI = NoticeAPI()
    @ObservedObject var ingangAPI = IngangAPI()
    @ObservedObject var userAPI = UserAPI()
    @ObservedObject var timetableAPI = TimetableAPI()
    @ObservedObject var attendanceLogAPI = AttendanceLogAPI()
    @ObservedObject var placeAPI = PlaceAPI()
    @State var tapbarIndex = 2
    @State var isShowIdCard = false
    @State var dragOffset = CGSize.zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    HStack(spacing: 0){
                        ProfileView()
                            .environmentObject(tokenAPI)
                            .environmentObject(userAPI)
                            .environmentObject(noticeAPI)
                            .environmentObject(alertManager)
                        IngangView()
                            .environmentObject(tokenAPI)
                            .environmentObject(alertManager)
                            .environmentObject(ingangAPI)
                        HomeView(isShowIdCard: $isShowIdCard)
                            .environmentObject(tokenAPI)
                            .environmentObject(mealAPI)
                            .environmentObject(alertManager)
                            .environmentObject(userAPI)
                            .environmentObject(attendanceLogAPI)
                            .environmentObject(placeAPI)
                            .environmentObject(ingangAPI)
                        MealView()
                            .environmentObject(mealAPI)
                        TimetableView()
                            .environmentObject(timetableAPI)
                            .environmentObject(userAPI)
                            .environmentObject(alertManager)
                    }.frame(width: geometry.size.width*5)
                    .offset(x: -geometry.size.width*CGFloat((tapbarIndex))+dragOffset.width)
                    .animation(.interactiveSpring())
                    .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                                .onChanged { value in
                                    self.dragOffset = value.translation
                                }
                                .onEnded { value in
                                    self.dragOffset = .zero
                                    if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                                        nextPage()
                                    }
                                    else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                                        previousPage()
                                    }
                                }
                    )
                    TapBar(index: self.$tapbarIndex)
                        .offset(x: -geometry.size.width*2)
                        
                }
                StudentIdCardModalView(isShowing: $isShowIdCard)
                    .environmentObject(userAPI)
                    .frame(width: geometry.size.width)
                    .offset(x: -geometry.size.width*2)
                AlertView(isShowing: $alertManager.isShowing)
                    .environmentObject(alertManager)
                    .frame(width: geometry.size.width)
                    .offset(x: -geometry.size.width*2)
            }
        }
    }
    func nextPage() {
        if tapbarIndex != 4 {
            self.tapbarIndex += 1
        }
        
    }
    func previousPage() {
        if tapbarIndex != 0 {
            self.tapbarIndex -= 1
        }
    }
}
