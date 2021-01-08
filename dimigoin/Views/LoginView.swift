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
import CMLoadingButton

struct LoginView: View {
    @EnvironmentObject var tokenAPI: TokenAPI
    @EnvironmentObject var alertManager: AlertManager
    @State var username = ""
    @State var password = ""
    @State var showErrorMessage:Bool = false
    @State var isLoading: Bool = false
    var buttonStyle = CMButtonStyle(width:345, height: 60, cornerRadius: 5, backgroundColor: Color("accent"))
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Spacer()
                VStack {
                    HStack(alignment: .center){
                        Image("logo").resizable().frame(width: 50.5, height: 47.76)
                        HSpacer(24)
                        Text("디미고인").logoFont()
                    }
                    VSpacer(30)
                    TextField("아이디", text: $username).textContentType(.username)
                        .accessibility(identifier: "textfield.username")
                        .modifier(TextFieldModifier())
                        .modifier(ClearButton(text: $username))
                    VSpacer(16)
                    SecureField("패스워드", text: $password, onCommit: {
                        dismissKeyboard()
                    }).accessibility(identifier: "textfield.password")
                        .textContentType(.password)
                        .modifier(TextFieldModifier())
                        .modifier(ClearButton(text: $password))
                    VSpacer(13)
                    LoadingButton(action: {
                        LOG("get token")
                        isLoading = true
                        let parameters: [String: String] = [
                            "username": "\(self.username)",
                            "password": "\(self.password)"
                        ]
                        let endPoint = "/auth"
                        let method:HTTPMethod = .post
                        AF.request(rootURL+endPoint, method: method, parameters: parameters, encoding: JSONEncoding.default).response { response in
                            if let status = response.response?.statusCode {
                                switch(status) {
                                case 200:
                                    let json = JSON(response.value!!)
                                    self.tokenAPI.accessToken = json["accessToken"].string!
                                    self.tokenAPI.refreshToken = json["refreshToken"].string!
                                    self.dismissKeyboard()
                                    self.tokenAPI.debugToken()
                                    self.tokenAPI.saveTokens()
                                    self.tokenAPI.tokenStatus = .exist
                                    isLoading = false
                                default:
                                    LOG("get token failed")
                                    alertManager.createAlert("로그인에 실패했습니다.", sub: "아이디 혹은 패스워드를 확인해주세요", .danger)
                                    debugPrint(response)
                                    self.tokenAPI.tokenStatus = .none
                                    isLoading = false
                                }
                            }
                        }
                    }, isLoading: $isLoading, style: buttonStyle) {
                        Text("로그인")
                            .font(Font.custom("NotoSansKR-Bold", size: 18))
                            .foregroundColor(Color.white)
                    }.accessibility(identifier: "button.login")
                }
                Spacer()
                CopyrightText()
            }.padding(.horizontal)
            
            AlertView(isShowing: $alertManager.isShowing)
                .environmentObject(alertManager)
        }
    }
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
