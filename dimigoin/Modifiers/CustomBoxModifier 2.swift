//
//  CustomBoxModifier.swift
//  dimigoin
//
//  Created by 변경민 on 2020/07/05.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct CustomBoxModifier: ViewModifier {
    func body(content: Content) -> some View {
        return (
            content
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: Color("ShadowColor"), radius: 20, x: 0, y: 0)
        )
    }
}

extension VStack {
    func CustomBox() -> some View {
        return self.frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            .padding()
            .background(Color.white)
            .cornerRadius(5)
            .shadow(color: Color("ShadowColor"), radius: 20, x: 0, y: 0)
    }
}

extension HStack {
    func CustomBox() -> some View {
        return self.frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            .padding()
            .background(Color.white)
            .cornerRadius(5)
            .shadow(color: Color("ShadowColor"), radius: 20, x: 0, y: 0)
    }
}

struct CustomBoxModifier_Previews: PreviewProvider {
    static var previews: some View {
        HStack { Text("RoundBoxModifier Preview") }
        .padding()
        .modifier(CustomBoxModifier())
        .previewLayout(.sizeThatFits)
    }
}
