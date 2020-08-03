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
    
    var body: some View {
        ZStack {
            Background()
            Image("school").resizable().scaledToFit().offset(y: UIScreen.screenHeight/2 - 40)
            VStack(alignment: .center) {
                Spacer()
                VStack {
                    HStack {
                        Image("FullLogo").resizable().frame(width: 240, height: 64)
                    }
                    VSpacer(30)
                    TextField("아이디", text: $id)
                        .modifier(TextFieldModifier())
                        .modifier(ClearButton(text: $id))
                    VSpacer(16)
                    SecureField("비밀번호", text: $password)
                        .modifier(TextFieldModifier())
                        .modifier(ClearButton(text: $password))
                    VSpacer(13)
                    Text("아이디 혹은 비밀번호를 확인해 주세요").highlightRed().caption2().opacity(showErrorMessage ? 1:0)
                    VSpacer(13)
                    Button(action: {
                        isLoading = true
                        tokenAPI.set(id: self.id, password: self.password)
                        let tokenStatus: TokenStatus = tokenAPI.getTokens()
                        if(tokenStatus == .exist) {
                            // navigation to main
                            navigateToMainView()
                        }
                        else if(tokenStatus == .fail) {
                            self.showErrorMessage = true
                        }
                    }) {
                        Text("로그인").SquareButton(312, 27)
                    }
                }
                Spacer()
                Text("© 2020 ").caption2()
                +
                Text("DIMIGOIN").caption2().bold()
                +
                Text(" Communications").caption2()
//                Text("© 2020 DIMIGOIN Communicaions").caption2().bold()
                
            }.padding(.horizontal)
            .keyboardResponsive()
            
            if #available(iOS 14.0, *) {
                if(isLoading) {
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
            } else {
                // Fallback on earlier versions
            }
            
        }
    }
    func navigateToMainView() {
        
    }
}
