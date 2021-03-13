//
//  LoginView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import DimigoinKit
import Firebase

struct LoginView: View {
    @EnvironmentObject var api: DimigoinAPI
//    @EnvironmentObject var alertManager: AlertManager
    @State var username = ""
    @State var password = ""
    @State var showErrorMessage: Bool = false
    @State var isLoading: Bool = false
    @State var showPassword: Bool = false
    @Namespace var loginView
    
    var body: some View {
        ZStack {
            if !api.isFetching {
                VStack(alignment: .center) {
                    Spacer()
                    VStack {
                        Image("logo").templateImage(width: 45, Color.accent)
                            .matchedGeometryEffect(id: "logo", in: loginView)
                        VSpacer(43.5)
                        TextField("아이디를 입력하세요", text: $username).textContentType(.username)
                            .accessibility(identifier: "textfield.username")
                            .modifier(TextFieldModifier(isError: $showErrorMessage))
                            .modifier(ClearButton(text: $username))
                        VSpacer(10)
                        if showPassword {
                            TextField("패스워드를 입력하세요", text: $password, onCommit: {
                                dismissKeyboard()
                            }).textContentType(.password)
                                .accessibility(identifier: "textfield.password")
                                .modifier(TextFieldModifier(isError: $showErrorMessage))
                                .modifier(ClearButton(text: $password))
                                .modifier(RevealButton(text: $password, showPassword: $showPassword))
                        } else {
                            SecureField("패스워드를 입력하세요", text: $password, onCommit: {
                                dismissKeyboard()
                            }).textContentType(.password)
                                .accessibility(identifier: "textfield.password")
                                .modifier(TextFieldModifier(isError: $showErrorMessage))
                                .modifier(ClearButton(text: $password))
                                .modifier(RevealButton(text: $password, showPassword: $showPassword))
                        }
                        if showErrorMessage {
                            VSpacer(17)
                            Text("존재하지 않는 아이디거나 잘못된 패스워드입니다.")
                                .notoSans(.medium, size: 12, Color("red"))
                            VSpacer(17)
                        } else {
                            VSpacer(30)
                        }
                        Button(action: {
                            self.isLoading = true
                            api.login(username, password, FCMToken) { result in
                                if result == true {
                                    self.isLoading = false
                                    
                                } else {
                                    self.isLoading = false
                                    self.showErrorMessage = true
                                }
                            }
                        }) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                }
                                HSpacer(10)
                                Text("로그인")
                                    .notoSans(.bold, size: 18)
                                    .foregroundColor(Color.white)
                            }
                            .frame(width: 335, height: 50)
                            .background(Color(isLoading ? "disabled-button": "accent").cornerRadius(10))
                        }.accessibility(identifier: "button.login")
                    }.animation(.easeInOut)
                    VSpacer(20)
                    Button(action: {
//                        alertManager.createAlert("아이디 또는 패스워드를 잊으셨나요?", sub: "계정을 분실하셨다면 본관 1층 교무실\nIT 특성화부 하미영 선생님께 문의 하시기 바랍니다", .text)
                    }) {
                        HStack {
                            Image("infomark").frame(width: 13, height: 13)
                            Text("아이디 또는 비밀번호를 잊으셨나요?").notoSans(.medium, size: 12, Color("disabled"))
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .edgesIgnoringSafeArea(.top)
                .keyboardResponsive()
//                Color.black.edgesIgnoringSafeArea(.all).opacity(alertManager.isShowing ? 0.1 : 0)
//                AlertView()
//                    .environmentObject(api)
//                    .environmentObject(alertManager)
            } else {
                Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)
                Image("logo").templateImage(width: 73, Color.accent)
                    .matchedGeometryEffect(id: "logo", in: loginView)
                    .offset(y: -50)
                    .padding(.horizontal)
            }
        }
    }
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
