//
//  TemplateImageModifier.swift
//  dimigoin
//
//  Created by 변경민 on 2021/02/03.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI

extension Image {
    func templateImage(width: CGFloat, height: CGFloat, _ color: Color) -> some View {
        self.renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
            .foregroundColor(color)
    }
    func templateImage(width: CGFloat, _ color: Color) -> some View {
        self.renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width)
            .foregroundColor(color)
    }
    func templateImage(height: CGFloat, _ color: Color) -> some View {
        self.renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: height)
            .foregroundColor(color)
    }
}
