//
//  ClearButton.swift
//  dimigoin
//
//  Created by 변경민 on 2020/07/05.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct ClearButton: ViewModifier {
    @Binding var text: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content

            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color("gray6"))
                        .font(.system(size: 15))
                        .zIndex(1)
                }
                .padding(.trailing, 12)
            }
        }
    }
}

struct SearchBarClearButton: ViewModifier {
    @Binding var text: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content

            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color("gray6"))
                        .font(.system(size: 15))
                        .zIndex(1)
                }
                .padding(.trailing, 37)
                
            }
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("gray6"))
                .font(.system(size: 18))
                .zIndex(1)
                .padding(.trailing, 12)
        }
    }
}
