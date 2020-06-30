//
//  PrimaryButtonModifier.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(Font.body.bold())
            .padding()
            .background(Color("Primary"))
            .foregroundColor(Color.white)
            .cornerRadius(7.0)
    }
}

struct PrimaryButtonModifier_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("버튼")
        }
        .modifier(PrimaryButtonModifier())
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
