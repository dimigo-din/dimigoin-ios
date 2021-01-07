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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @EnvironmentObject var mealAPI: MealAPI
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var tokenAPI : TokenAPI
    @EnvironmentObject var userAPI: UserAPI
    @EnvironmentObject var attendanceLogAPI: AttendanceLogAPI
    @EnvironmentObject var placeAPI: PlaceAPI
    @EnvironmentObject var ingangAPI: IngangAPI
    @Binding var isShowIdCard: Bool
    @State var currentLocation = 0
    
    func isAppliedAnyIngang() -> Bool {
        for i in 0..<ingangAPI.ingangs.count {
            if(ingangAPI.ingangs[i].isApplied == true){
                return true
            }
        }
        return false
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false){
                VStack{
                    ZStack {
                        VStack {
                            VSpacer(50)
                            if(horizontalSizeClass == .compact) {
                                Image("school").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: .infinity).opacity(0.3)
                            }
                            else {
                                Image("school").resizable().frame(maxWidth: .infinity).opacity(0.3)
                            }
                        }
                        
                        HStack {
                            Image("logo").resizable().aspectRatio(contentMode: .fit).frame(height: 38)
                            Spacer()
                            Button(action: {
                                showIdCardAfterAuthentication()
//                                showIdCard()
                            }) {
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
                    if(isAppliedAnyIngang()) {
                        SectionHeader("나의 신청현황", sub: "")
                    }
                    ForEach(0..<ingangAPI.ingangs.count, id: \.self) { i in
                        if(ingangAPI.ingangs[i].isApplied == true) {
                            HStack {
                                VStack(alignment: .leading, spacing: 5){
                                    Text("오늘의 인강실").font(Font.custom("NotoSansKR-Bold", size: 17))
                                    HStack {
                                        Image("clock").frame(width: 20)
                                        Text("\(ingangAPI.ingangs[i].title)").gray4().caption3()
                                    }
                                    HStack {
                                        Image("map.pin").frame(width: 20)
                                        Text("\(userAPI.user.grade)학년 인강실").gray4().caption3()
                                    }
                                }
                            }.padding()
                            .frame(width: abs(geometry.size.width-40), alignment: .leading)
                            .background(CustomBox())
                            .fixedSize(horizontal: false, vertical: true)
                        }
                    }
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


