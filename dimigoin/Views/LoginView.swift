//
//  LoginView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var tokenAPI: TokenAPI
    @ObservedObject var alertManager: AlertManager
    @State var id = ""
    @State var password = ""
    @State var showErrorMessage:Bool = false
    @State var isLoading: Bool = false
    
    init(tokenAPI: TokenAPI, alertManager: AlertManager) {
        self.tokenAPI = tokenAPI
        self.alertManager = alertManager
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Spacer()
                VStack {
                    HStack(alignment: .center){
                        Image("Logo").resizable().frame(width: 50.5, height: 47.76)
                        HSpacer(24)
                        Text("디미고인").logoFont()
                    }
                    VSpacer(30)
                    TextField("아이디", text: $id).textContentType(.username)
                        .modifier(TextFieldModifier())
                        .modifier(ClearButton(text: $id))
                    VSpacer(16)
                    SecureField("패스워드", text: $password).textContentType(.password)
                        .modifier(TextFieldModifier())
                        .modifier(ClearButton(text: $password))
                    VSpacer(13)
                    Text("아이디 혹은 비밀번호를 확인해 주세요").warning().caption2()
                        .opacity(showErrorMessage ? 1:0)
                    VSpacer(13)
                    Button(action: {
                        isLoading = true
                        tokenAPI.set(id: self.id, password: self.password)
                        tokenAPI.getTokens()
                        if(tokenAPI.tokenStatus == .exist) {
                            self.showErrorMessage = false
                        }
                        else if(tokenAPI.tokenStatus == .none) {
                            self.showErrorMessage = true
                            self.isLoading = false
                        }
                    }) {
                        Text("로그인").SquareButton(312, 27)
                    }
                }
                Spacer()
                CopyrightText()
            }.padding(.horizontal)
            if #available(iOS 14.0, *) {
                if(isLoading) {
                    ProgressView() {
                        HStack {
                            Text("로딩중").accent().caption1()
                        }
                    }.progressViewStyle(CircularProgressViewStyle(tint: Color("accent")))
                }

            } else {
                // Fallback on earlier versions
            }
            
        }
    }
}
