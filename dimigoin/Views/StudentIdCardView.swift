//
//  StudentIdCardView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/10.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct StudentIdCardView: View {
    @ObservedObject var alertManager: AlertManager
    var body: some View {
        ScrollView {
            Button(action: {
//                self.tokenAPI.clearTokens()
            }) {
                Text("로그아웃").SquareButton(312, 54)
            }
            Button(action: {
                alertManager.present("취소되었습니다", sub: "내정보 탭에서 신청 목록을 확인하실 수 있습니다", .cancel)
            }) {
                Text("alert").SquareButton(312, 54)
            }
            Button(action: {
                alertManager.present("danger", sub: "danger", .danger)
            }) {
                Text("alert").SquareButton(312, 54)
            }
        }
    }
}
