//
//  StudentIdCardView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/10.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit
import LocalAuthentication

struct StudentIdCardView: View {
//    @EnvironmentObject var alertManager: AlertManager
//    @EnvironmentObject var tokenAPI: TokenAPI
    @State private var isShowIdCard: Bool = false
    @State var tmp: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    ViewTitle("학생증", sub: "모바일 학생증", icon: "idcard")
                    Spacer()
                }
                VStack(){
                    if tmp == false {
                        Rectangle()
                            .foregroundColor(Color.accent)
                            .frame(width: geometry.size.width-40, height: 195)
                            .cornerRadius(10)
                    } else {
                        Rectangle()
                            .foregroundColor(Color.red)
                            .frame(width: 473, height: 275)
                            .cornerRadius(10)
//                            .offset(x: 40, y: geometry.size.width-275)
                    }
                }
                .rotation3DEffect(Angle(degrees: tmp ? 180 : 0), axis: (x: 1, y: -1, z: 0))
                .onTapGesture {
                    withAnimation(Animation.easeOut(duration: 3).delay(3)) {
                        tmp.toggle()
                    }
                    
                }
            }
        }
    }
    
//    func showIdCardAfterAuthentication() {
//        let context = LAContext()
//        var error: NSError?
//
//        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
//            alertManager.createAlert("학생증 열기 실패", sub: "학생증을 보시려면 핸드폰의 잠금을 설정시거나 앱의 접근 권한을 허용해주세요.", .danger)
//            return
//        }
//
//        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
//            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "모바일 학생증보기", reply: { (success, error) in
//                if success {
//                    DispatchQueue.main.async {
//                        showIdCard()
//                    }
//                }else {
//                    DispatchQueue.main.async {
//                        print("Authentication was error")
//                    }
//                }
//            })
//        }else {
//            alertManager.createAlert("인증에 실패했습니다.", sub: "학생증을 보시려면 생체인증을 진행하거나, 비밀번호를 입력해야 합니다.", .danger)
//        }
//    }
    func showIdCard() {
        withAnimation(Animation.easeInOut(duration: 10)) {
            self.isShowIdCard.toggle()
        }
    }
    func dismissIdCard() {
        withAnimation(.spring()) {
            self.isShowIdCard = false
        }
    }
}




        
    
//                VStack {
//                    HStack {
//                        Image("dimigo-logo").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(height: 19).foregroundColor(Color.white).padding(.leading, 25).padding(.top)
//                        Spacer()
//                        Image(systemName: "chevron.right").padding(.trailing, 25).foregroundColor(Color.white).padding(.top)
//                    }
//                    Spacer()
//                    Text("터치하여 모바일 학생증 열기").font(Font.custom("NanumSquareB", size: 12)).disabled().padding(.bottom).opacity(0.8)
//                }.frame(width: geometry.size.width-40, height: 195, alignment: .top)
//                .background(
//                    Color.accent.cornerRadius(10)
//
//                )
//                .horizonPadding()
//                .onTapGesture {
//                    withAnimation(.easeInOut(duration: 3)) {
//                        self.isShowIdCard.toggle()
//                    }
//                }
//                .matchedGeometryEffect(id: "box", in: namespace)
