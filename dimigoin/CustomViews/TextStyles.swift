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
    func highlightRed() -> Text {
        self
            .foregroundColor(Color("Secondary"))
    }
    func disabled() -> Text {
        self
            .foregroundColor(Color("Disabled"))
    }
    func navigationBarTitle() -> Text {
        self
            .font(Font.custom("NanumSquare", size: 40))
    }
    func sectionHeader() -> Text {
        self
            .font(Font.custom("NanumSquareEB", size: 27))
    }
    func body() -> Text {
        self
            .font(Font.custom("NanumSquareR", size: 15))
    }
    func headline() -> Text {
        self
            .font(Font.custom("NanumSquare", size: 17))
    }
    func heavy() -> Text {
        self
            .fontWeight(.heavy)
    }
    func black() -> Text {
        self
            .fontWeight(.black)
    }
    func caption1() -> Text {
        self
            .font(Font.custom("NanumSquareR", size: 15))
    }
    func caption2() -> Text {
        self
            .font(Font.custom("NanumSquareR", size: 13))
    }
    func caption3() -> Text {
        self
            .font(Font.custom("NanumSquareR", size: 11))
    }
    func SquareButton(_ w:CGFloat, _ h:CGFloat) -> some View {
        self
            .font(Font.custom("NanumSquareB", size: 17))
            .frame(width: w, height: h)
            .padding()
            .background(Color("Primary"))
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
    }
    func SquareButtonRed(_ w:CGFloat, _ h:CGFloat) -> some View {
        self
            .font(Font.custom("NanumSquareB", size: 17))
            .frame(width: w, height: h)
            .padding()
            .background(Color("Secondary"))
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
    }
}
