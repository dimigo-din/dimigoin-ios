//
//  HeadlineModifier.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/28.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct HeadlineModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.headline)
            .foregroundColor(Color("Highlight"))
    }
}

struct HeadlineModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("헤드라인 텍스트")
            .modifier(HeadlineModifier())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
