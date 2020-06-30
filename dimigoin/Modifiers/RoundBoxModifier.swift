//
//  RoundBoxModifier.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/28.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct RoundBoxModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            .padding()
            .background(Color.white)
            .cornerRadius(10.0)
            .shadow(color: Color("ShadowColor"), radius: 15, x: 5, y: 5)
    }
}

struct RoundBoxModifier_Previews: PreviewProvider {
    static var previews: some View {
        HStack { Text("RoundBoxModifier Preview") }
            .padding()
            .modifier(RoundBoxModifier())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

