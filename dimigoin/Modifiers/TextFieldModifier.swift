//
//  TextFieldModifier.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    @Binding var isError: Bool
    init(isError: Binding<Bool>) {
        self._isError = isError
    }
    init() {
        self._isError = .constant(false)
    }
    func body(content: Content) -> some View {
        return content
            .font(Font.custom("NanumSquareR", size: 14))
            .padding(.leading)
            .frame(width: 335, height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(isError ? "red" : "divider"), lineWidth: 1)
            )
            .disableAutocorrection(true)
            .autocapitalization(.none)
            
    }
}
