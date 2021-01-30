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

struct LoginView: View {
    @EnvironmentObject var api: DimigoinAPI
    @EnvironmentObject var alertManager: AlertManager
    @State var username = ""
    @State var password = ""
    @State var showErrorMessage:Bool = false
    @State var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Spacer()
                VStack {
                    Image("logo").resizable().aspectRatio(contentMode: .fit).frame(height: 42.8)
                    VSpacer(43.5)
                    TextField("아이디를 입력하세요", text: $username).textContentType(.username)
                        .accessibility(identifier: "textfield.username")
                        .modifier(TextFieldModifier(isError: $showErrorMessage))
                        .modifier(ClearButton(text: $username))
                    VSpacer(10)
                    SecureField("패스워드를 입력하세요", text: $password, onCommit: {
                        dismissKeyboard()
                    }).textContentType(.password)
                        .accessibility(identifier: "textfield.password")
                        .modifier(TextFieldModifier(isError: $showErrorMessage))
                        .modifier(ClearButton(text: $password))
                    if showErrorMessage {
                        VSpacer(17)
                        Text("존재하지 않는 아이디거나 잘못된 패스워드입니다.").font(Font.custom("NotoSansKR-Medium", size: 12)).warning()
                        VSpacer(17)
                    } else {
                        VSpacer(30)
                    }
                    Button(action : {
                        self.isLoading = true
                        api.login(username, password) { result in
                            if result == true {
                                self.isLoading = false
                            } else {
                                self.isLoading = false
                                self.showErrorMessage = true
                            }
                        }
                    }) {
                        HStack {
                            if(isLoading) {
                                if #available(iOS 14.0, *) {
                                    ProgressView()
                                }
                            }
                            HSpacer(10)
                            Text("로그인")
                                .font(Font.custom("NotoSansKR-Bold", size: 18))
                                .foregroundColor(Color.white)
                        }
                        .frame(width: 335, height: 50)
                        .background(Color(isLoading ? "disabled-button": "accent").cornerRadius(10))
                    }.accessibility(identifier: "button.login")
                }.animation(.easeInOut)
                VSpacer(20)
                Button(action: {
                    alertManager.createAlert("아이디 또는 패스워드를 잊으셨나요?", sub: "계정을 분실하셨다면 본관 1층 교무실\nIT 특성화부 하미영 선생님께 문의 하시기 바랍니다", .text)
                }) {
                    HStack {
                        Image("infomark").frame(width: 13, height: 13)
                        Text("아이디 또는 비밀번호를 잊으셨나요?").font(Font.custom("NotoSansKR-Medium", size: 12)).disabled()
                    }
                }
                Spacer()
            }.padding(.horizontal)
            .edgesIgnoringSafeArea(.top)
            .keyboardResponsive()
            AlertView()
                .environmentObject(alertManager)
        }
    }
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
