//
//  ProfileView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 15.0) {
                HStack {
                    Text("이름").modifier(HeadlineModifier())
                    Text("엄서훈")
                }.modifier(RoundBoxModifier())
                
                HStack {
                    Text("아이디").modifier(HeadlineModifier())
                    Text("uhmtoto")
                }.modifier(RoundBoxModifier())
                
                HStack {
                    Text("학적").modifier(HeadlineModifier())
                    Text("2학년 5반 19번 (해킹방어과)")
                }.modifier(RoundBoxModifier())
                
                HStack {
                    Text("금주 잔여 인강실 티켓").modifier(HeadlineModifier())
                    Text("5개")
                }.modifier(RoundBoxModifier())
                
                HStack {
                    Text("금일 잔여 인강실 티켓").modifier(HeadlineModifier())
                    Text("2개")
                }.modifier(RoundBoxModifier())
                
                Button(action: {
                    if let url = URL(string: "https://student.dimigo.hs.kr/user/profile") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("프로필 수정하기").modifier(HeadlineModifier())
                }.modifier(RoundBoxModifier())
                
                Spacer()
            }.padding()
            .navigationBarTitle("나의 프로필")
            .navigationBarItems(
                trailing: Button(action: {}) {
                    Text("로그아웃")
                }
            )
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
