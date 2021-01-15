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
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var tokenAPI: TokenAPI
    @Binding var isShowIdCard: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading){
                ViewTitle("학생증", sub: "모바일 학생증").horizonPadding().padding(.top, 30)
                Button(action: {
                    showIdCard()
//                    showIdCardAfterAuthentication()
                }){
                    HStack {
                        Image("idcard").renderingMode(.template).foregroundColor(Color.systemBackground).padding(.leading, 25)
                        HSpacer(17.5)
                        Text("모바일 학생증").font(Font.custom("NotoSansKR-Bold", size: 16)).foregroundColor(Color.systemBackground)
                        Spacer()
                        Image(systemName: "chevron.right").padding(.trailing, 25).foregroundColor(Color.systemBackground)
                    }
                    .frame(width: geometry.size.width-40, height: 55)
                    .background(Color.accent.cornerRadius(10))
                    .horizonPadding()
                }
                Button(action: {
                    tokenAPI.clearTokens()
                }){
                    HStack {
                        Image("logout").renderingMode(.template).foregroundColor(Color.systemBackground).padding(.leading, 25)
                        HSpacer(17.5)
                        Text("로그아웃(임시)").font(Font.custom("NotoSansKR-Bold", size: 16)).foregroundColor(Color.systemBackground)
                        Spacer()
                        Image(systemName: "chevron.right").padding(.trailing, 25).foregroundColor(Color.systemBackground)
                    }
                    .frame(width: geometry.size.width-40, height: 55)
                    .background(Color.accent.cornerRadius(10))
                    .horizonPadding()
                }
            }
            
        }
    }
    
    func showIdCardAfterAuthentication() {
        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            alertManager.createAlert("학생증 열기 실패", sub: "학생증을 보시려면 핸드폰의 잠금을 설정시거나 앱의 접근 권한을 허용해주세요.", .danger)
            return
        }

        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "모바일 학생증보기", reply: { (success, error) in
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
