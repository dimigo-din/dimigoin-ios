//
//  HelperTextModifier.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/29.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct HelperTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.callout)
            .foregroundColor(Color("HelperMessage"))
    }
}

struct HelperTextModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("헬퍼 텍스트")
            .modifier(HelperTextModifier())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
