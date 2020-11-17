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
    @EnvironmentObject var tokenAPI: TokenAPI
    @EnvironmentObject var alertManager: AlertManager
    @State var id = ""
    @State var password = ""
    @State var showErrorMessage:Bool = false
    @State var isLoading: Bool = false
    
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
                    TextField("아이디", text: $id).textContentType(.username)
                        .modifier(TextFieldModifier())
                        .modifier(ClearButton(text: $id))
                    VSpacer(16)
                    SecureField("패스워드", text: $password).textContentType(.password)
                        .modifier(TextFieldModifier())
                        .modifier(ClearButton(text: $password))
                    VSpacer(13)
                    Button(action: {
                        print("get token")
                        isLoading = true
                        let parameters: [String: String] = [
                            "id": "\(self.id)",
                            "password": "\(self.password)"
                        ]
                        let url: String = "https://api.dimigo.in/auth/"
                        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
                            if let status = response.response?.statusCode {
                                switch(status) {
                                case 200:
                                    let json = JSON(response.value!!)
                                    self.tokenAPI.tokens.token = json["token"].string!
                                    self.tokenAPI.tokens.refresh_token = json["refresh_token"].string!
                                    self.tokenAPI.debugToken()
                                    self.tokenAPI.saveTokens()
                                    self.tokenAPI.tokenStatus = .exist
                                    isLoading = false
                                default:
                                    print("get token failed")
                                    alertManager.createAlert("로그인에 실패했습니다.", sub: "아이디 혹은 패스워드를 확인해주세요", .danger)
                                    debugPrint(response)
                                    self.tokenAPI.tokenStatus = .none
                                    isLoading = false
                                }
                            }
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
                    Rectangle().fill(Color("gray3")).opacity(0.3).edgesIgnoringSafeArea(.all)
                    ProgressView()
                }
            }
            if(alertManager.isShowing) {
                AlertView(alertType: alertManager.alertType, content: alertManager.content, sub: alertManager.sub, isShowing: $alertManager.isShowing)
            }
            
        }
    }
}
