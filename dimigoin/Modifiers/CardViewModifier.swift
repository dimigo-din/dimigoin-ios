//
//  RoundBoxModifier.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/28.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct CardViewModifier: ViewModifier {
    var width: CGFloat
    var height: CGFloat
    init(_ width: CGFloat, _ height: CGFloat) {
        self.width = width
        self.height = height
    }
    func body(content: Content) -> some View {
        return content
            .frame(width: abs(width), height: abs(height), alignment: .topLeading)
            .background(Color(UIColor.secondarySystemGroupedBackground).cornerRadius(10).shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0))
    }
}
