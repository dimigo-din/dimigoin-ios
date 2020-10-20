//
//  ProfileView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import SPAlert

struct ProfileView: View {
    @ObservedObject var tokenAPI: TokenAPI
    @ObservedObject var userAPI: UserAPI
    @ObservedObject var optionAPI: OptionAPI
    @State var showOption: Bool = false
    
    init(tokenAPI: TokenAPI, userAPI: UserAPI, optionAPI: OptionAPI) {
        self.tokenAPI = tokenAPI
        self.userAPI = userAPI
        self.optionAPI = optionAPI
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 15.0) {
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("이름").highlight().headline()
                        Spacer()
                        Text(userAPI.user.name).foregroundColor(Color("DisabledButton"))
                    }
                    Divider().offset(x: 35)
                    HStack {
                        Text("학적").highlight().headline()
                        Spacer()
                        Text("\(userAPI.user.grade)학년 \(userAPI.user.klass)반 \(userAPI.user.number)번 (\(getMajor(klass: userAPI.user.klass)))").foregroundColor(Color("DisabledButton"))
                    }
                    Divider().offset(x: 35)
                    HStack {
                        Text("금주 잔여 인강실 티켓").highlight().headline()
                        Spacer()
                        Text("\(userAPI.user.weekly_ticket_num)").foregroundColor(Color("DisabledButton"))
                    }
                    Divider().offset(x: 35)
                    HStack {
                        Text("금일 잔여 인강실 티켓").highlight().headline()
                        Spacer()
                        Text("\(userAPI.user.daily_ticket_num)").foregroundColor(Color("DisabledButton"))
                    }
                }.CustomBox()
                Button(action: {
                    if let url = URL(string: "https://student.dimigo.hs.kr/user/profile") {
                        UIApplication.shared.open(url)
                    }
                    
                }) {
                    Text("프로필 수정하기").SquareButton(312, 27)
                }
                Button(action: {
                    SPAlert.present(message: "성공적으로 로그아웃 되었습니다")
                    tokenAPI.clearTokens()
                }) {
                    Text("로그아웃").SquareButtonRed(312, 27)
                }
                Spacer()
                CopyrightText()
            }.padding()
            .navigationBarTitle("\(userAPI.user.name)님의 프로필")
            .navigationBarItems(
                trailing: Button(action: {
                    self.showOption.toggle()
                }) {
                    Image(systemName: "gear").resizable().frame(width: 25, height: 25)
                }
                .sheet(isPresented: $showOption) {
                    OptionView(optionAPI: optionAPI)
                }
            )
            
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(user: dummyUser)
//    }
//}
