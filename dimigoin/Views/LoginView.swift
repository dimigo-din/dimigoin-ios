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
        VStack {
            Text("로그인")
                .font(.largeTitle)
            TextField("디미고인 아이디를 입력해 주세요", text: $id)
                .modifier(TextFieldModifier())
            SecureField("디미고인 비밀번호를 입력해 주세요", text: $password)
                .modifier(TextFieldModifier())
            Spacer()
                .frame(height:30)
            Button(action: {}) {
                Text("로그인")
            }.modifier(PrimaryButtonModifier())
        }.padding(.horizontal)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
