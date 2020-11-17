//
//  AssignView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct ProfileView: View {
    @EnvironmentObject var userAPI: UserAPI
    @EnvironmentObject var tokenAPI: TokenAPI
    @EnvironmentObject var alertManager: AlertManager
    
    var body: some View {
        ScrollView {
            HStack {
                ViewTitle("내정보", sub: "")
                Spacer()
            }.horizonPadding()
            .padding(.top, 40)
            HDivider().horizonPadding().offset(y: -15)
            ScrollView {
                Button(action: {
                    self.tokenAPI.clearTokens()
                }) {
                    Text("로그아웃").SquareButton(312, 54)
                }
                Button(action: {
                    alertManager.createAlert("취소되었습니다", sub: "내정보 탭에서 신청 목록을 확인하실 수 있습니다", .cancel)
                }) {
                    Text("cancel").SquareButton(312, 54)
                }
                Button(action: {
                    alertManager.createAlert("권한이 부족합니다", sub: "계속하시려면 권한을 보유한 계정으로 로그인하세요", .danger)
                }) {
                    Text("danger").SquareButton(312, 54)
                }
                Button(action: {
                    alertManager.createAlert("신청이 완료되었습니다", sub: "해당 탭에서 신청 목록을 확인하실 수 있습니다", .success)
                }) {
                    Text("success").SquareButton(312, 54)
                }
                Button(action: {
                    alertManager.createAlert("오류가 발생했습니다", sub: "이 화면이 계속 나타난다면 관리자에게 문의하세요", .warning)
                }) {
                    Text("error").SquareButton(312, 54)
                }
                
            }
        }
    }
}
