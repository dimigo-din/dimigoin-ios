//
//  RevealButton.swift
//  dimigoin
//
//  Created by 변경민 on 2021/03/05.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI

struct RevealButton: ViewModifier {
    @Binding var text: String
    @Binding var showPassword: Bool

    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                if showPassword {
                    Button(action: {
                        self.showPassword.toggle()
                    }) {
                        Image(systemName: "eye.slash")
                            .foregroundColor(Color("gray6"))
                            .font(.system(size: 15))
                            .zIndex(1)
                    }
                    .padding(.trailing, 28)
                } else {
                    Button(action: {
                        self.showPassword.toggle()
                    }) {
                        Image(systemName: "eye")
                            .foregroundColor(Color("gray6"))
                            .font(.system(size: 15))
                            .zIndex(1)
                    }
                    .padding(.trailing, 28)
                }
            }
        }
    }
}
