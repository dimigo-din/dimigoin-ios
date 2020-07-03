//
//  TextStyles.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/07/04.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

extension Text {
    func highlight() -> Text {
        self
            .foregroundColor(Color("Highlight"))
    }
    func headline() -> Text {
       self
           .font(.headline)
    }
    func helperText() -> Text {
        self
            .font(.callout)
            .foregroundColor(Color("HelperMessage"))
    }
    func PrimaryButton() -> some View {
        self
            .font(Font.body.bold())
            .padding()
            .background(Color("Primary"))
            .foregroundColor(Color.white)
            .cornerRadius(7.0)
    }
    func caption() -> Text {
        self
            .font(.caption)
    }
    func body() -> Text {
        self
            .font(.body)
    }
}
