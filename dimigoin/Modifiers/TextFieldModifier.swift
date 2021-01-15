//
//  TextFieldModifier.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(Font.custom("NanumSquareR", size: 14))
            .padding(.leading)
            .frame(width: 335, height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("divider"), lineWidth: 1)
            )
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
}
