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
    @State var id = ""
    @State var password = ""
    @State var showErrorMessage:Bool = false
    @State var isLoading: Bool = false
    
    init(tokenAPI: TokenAPI) {
        self.tokenAPI = tokenAPI
    }
    
    var body: some View {
        ZStack {
            Background()
            Image("school").resizable().scaledToFit().offset(y: UIScreen.screenHeight/2 - 40)
            VStack(alignment: .center) {
                Spacer()
                VStack {
                    HStack(alignment: .bottom){
                        Image("Logo").resizable().frame(width: 60, height: 69)
                        HSpacer(30)
                        Text("디미고인").openas()
                    }
                    VSpacer(30)
                    TextField("아이디", text: $id).textContentType(.username)
                        .modifier(TextFieldModifier())
                        .modifier(ClearButton(text: $id))
                    VSpacer(16)
                    SecureField("비밀번호", text: $password).textContentType(.password)
                        .modifier(TextFieldModifier())
                        .modifier(ClearButton(text: $password))
                    VSpacer(13)
                    Text("아이디 혹은 비밀번호를 확인해 주세요").highlightRed().caption2().opacity(showErrorMessage ? 1:0)
                    VSpacer(13)
                    Button(action: {
                        isLoading = true
                        tokenAPI.set(id: self.id, password: self.password)
                        tokenAPI.getTokens()
                        if(tokenAPI.tokenStatus == .exist) {
                            // navigation to main
                            navigateToMainView()
                        }
                        else if(tokenAPI.tokenStatus == .none) {
                            self.showErrorMessage = true
                        }
                    }) {
                        Text("로그인").SquareButton(312, 27)
                    }
                }
                Spacer()
                CopyrightText()
                
            }.padding(.horizontal)
            .keyboardResponsive()
            
//            if #available(iOS 14.0, *) {
//                if(tokenAPI.isLoading) {
//                    ProgressView().progressViewStyle(CircularProgressViewStyle())
//                }
//            } else {
//                // Fallback on earlier versions
//            }
            
        }
    }
    func navigateToMainView() {
        
    }
}
