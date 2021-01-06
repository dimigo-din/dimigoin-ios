//
//  HomeView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit
import LocalAuthentication
import SDWebImageSwiftUI

struct HomeView: View {
    @EnvironmentObject var mealAPI: MealAPI
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var tokenAPI : TokenAPI
    @EnvironmentObject var userAPI: UserAPI
    @EnvironmentObject var attendanceLogAPI: AttendanceLogAPI
    @EnvironmentObject var placeAPI: PlaceAPI
    @Binding var isShowIdCard: Bool
    @State var currentLocation = 0
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false){
                VStack{
                    ZStack {
                        VStack {
                            VSpacer(50)
                            Image("school").resizable().aspectRatio(contentMode: .fit).frame(width: geometry.frame(in: .global).width).opacity(0.3)
                        }
                        HStack {
                            Image("logo").resizable().aspectRatio(contentMode: .fit).frame(height: 38)
                            Spacer()
                            Button(action: {
                                showIdCardAfterAuthentication()
                                
                            }) {
                                // MARK: replace userPhoto-sample to userImage when backend ready
                                withAnimation() {
                                    userAPI.userPhoto
                                        .resizable()
                                        .placeholder(Image(systemName: "person.crop.circle"))
                                        .foregroundColor(Color("accent"))
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 38)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle().stroke(Color("accent"), lineWidth: 2)
                                        )
                                }
                            }
                        }.horizonPadding()
                    }
                    VSpacer(15)
                    LocationSelectionView(currentLocation: $currentLocation)
                        .environmentObject(attendanceLogAPI)
                        .environmentObject(placeAPI)
                        .environmentObject(alertManager)
                    Spacer()
                    Text("오늘의 급식").font(Font.custom("NotoSansKR-Bold", size: 20)).horizonPadding()
                    MealPagerView()
                        .environmentObject(mealAPI)
                }
            }
        }
    }
    func showIdCardAfterAuthentication() {
        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            return
        }

        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "학생증을 보려면 인증을 완료해주세요", reply: { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        showIdCard()
                    }
                }else {
                    DispatchQueue.main.async {
                        print("Authentication was error")
                    }
                }
            })
        }else {
            alertManager.createAlert("인증에 실패했습니다.", sub: "학생증을 보시려면 생체인증을 진행하거나, 비밀번호를 입력해야 합니다.", .danger)
        }
    }
    func showIdCard() {
        withAnimation(.spring()) {
            self.isShowIdCard = true
        }
    }
    func dismissIdCard() {
        withAnimation(.spring()) {
            self.isShowIdCard = false
        }
    }
}


