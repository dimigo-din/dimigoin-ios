//
//  LoginView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var id = ""
    @State var password = ""
    
    var body: some View {
        ZStack {
            Background()
            VStack(alignment: .leading) {
                HStack {
                    Image("FullLogo").resizable().frame(width: 240, height: 64)
                }
                VSpacer(42)
                TextField("아이디", text: $id).modifier(TextFieldModifier())
                VSpacer(16)
                SecureField("비밀번호", text: $password).modifier(TextFieldModifier())
                VSpacer(30)
                Button(action: {
                    // login request
                }) {
                    Text("로그인").SquareButton(312, 27)
                }
            }.padding(.horizontal)
            .keyboardResponsive()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
