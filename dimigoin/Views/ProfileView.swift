//
//  ProfileView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var tokenAPI: TokenAPI
    @ObservedObject var userAPI: UserAPI
    @ObservedObject var optionAPI: OptionAPI
    @State var showOption: Bool = false
    @State var showingAlert: Bool = false
    
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
                        Text("이름").accent().headline()
                        Spacer()
                        Text(userAPI.user.name).foregroundColor(Color("DisabledButton"))
                    }
                    Divider().offset(x: 35)
                    HStack {
                        Text("학적").accent().headline()
                        Spacer()
                        Text("\(userAPI.user.grade)학년 \(userAPI.user.klass)반 \(userAPI.user.number)번 (\(getMajor(klass: userAPI.user.klass)))").foregroundColor(Color("DisabledButton"))
                    }
                    Divider().offset(x: 35)
                    HStack {
                        Text("금주 잔여 인강실 티켓").accent().headline()
                        Spacer()
                        Text("\(userAPI.user.weekly_ticket_num)").foregroundColor(Color("DisabledButton"))
                    }
                    Divider().offset(x: 35)
                    HStack {
                        Text("금일 잔여 인강실 티켓").accent().headline()
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
                    self.showingAlert = true
                }) {
                    Text("로그아웃").DisabledSquareButton(312, 27)
                }
                .alert(isPresented:$showingAlert) {
                    Alert(title: Text("로그아웃 하시겠습니까?"),
                          primaryButton: .destructive(Text("로그아웃")) {
                            tokenAPI.clearTokens()
                          },
                          secondaryButton: .cancel())
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
