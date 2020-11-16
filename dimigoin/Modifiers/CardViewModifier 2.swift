//
//  RoundBoxModifier.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/28.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct CardViewModifier: ViewModifier {
    var w: CGFloat
    var h: CGFloat
    init(_ w:CGFloat, _ h: CGFloat) {
        self.w = w
        self.h = h
    }
    func body(content: Content) -> some View {
        return content
            .frame(width: w, height: h)
            .background(Color.white.cornerRadius(10).shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0))
    }
}

