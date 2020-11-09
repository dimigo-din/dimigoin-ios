//
//  TextStyles.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/07/04.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

extension Text {
    func accent() -> Text {
        self.foregroundColor(Color("Accent"))
    }
    
    func warning() -> Text {
        self.foregroundColor(Color("Red"))
    }
    
    func sub() -> Text {
        self.foregroundColor(Color("Sub"))
    }
    
    func tapBarItem() -> Text {
        self.font(Font.custom("NanumSquareEB", size: 10))
    }
    
    func disabled() -> Text {
        self.foregroundColor(Color("Disabled"))
    }
    
    func title() -> Text {
        self.font(Font.custom("NotoSansKR-Black", size: 40))
    }
    
    func subTitle() -> Text {
        self
            .foregroundColor(Color("Gray4"))
            .font(Font.custom("NotoSansKR-Bold", size: 13))
    }
    func subSectionHeader() -> Text {
        self
            .foregroundColor(Color("Accent"))
            .font(Font.custom("NotoSansKR-Bold", size: 10))
    }
    
    func sectionHeader() -> Text {
        self.font(Font.custom("NotoSansKR-Bold", size: 21))
    }
    
    func mealMenu() -> some View {
        self
            .lineSpacing(12)
            .foregroundColor(Color("Gray2"))
            .font(Font.custom("NotoSansKR-Regular", size: 12))
            
    }
    func alertTitle(_ color: Color) -> some View {
        self
            .foregroundColor(color)
            .font(Font.custom("NotoSansKR-Medium", size: 19))
    }
    func alertSubTitle() -> some View {
        self
            .foregroundColor(Color("Gray2"))
            .font(Font.custom("NotoSansKR-Regular", size: 13))
    }
    func alertButton() -> some View {
        self
            .foregroundColor(Color("Gray4"))
            .font(Font.custom("NotoSansKR-Bold", size: 17))
    }
    func body() -> Text {
        self.font(Font.custom("NanumSquareR", size: 15))
    }
    
    func headline() -> Text {
        self.font(Font.custom("NanumSquare", size: 17))
    }
    
    func logoFont() -> Text {
        self.font(Font.custom("Openas", size: 57))
    }
    
    func heavy() -> Text {
        self.fontWeight(.heavy)
    }
    
    func black() -> Text {
        self.fontWeight(.black)
    }
    
    func caption1() -> Text {
        self.font(Font.custom("NotoSansKR-Bold", size: 12))
    }
    
    func caption2() -> Text {
        self.font(Font.custom("NanumSquareR", size: 13))
    }
    
    func caption3() -> Text {
        self.font(Font.custom("NanumSquareR", size: 11))
    }
    
    func SquareButton(_ w:CGFloat, _ h:CGFloat) -> some View {
        self
            .font(Font.custom("NanumSquareB", size: 18))
            .frame(width: w, height: h)
            .padding()
            .background(Color("Accent"))
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
    }
    
    func DisabledSquareButton(_ w:CGFloat, _ h:CGFloat) -> some View {
        self
            .font(Font.custom("NanumSquareB", size: 17))
            .frame(width: w, height: h)
            .padding()
            .background(Color("Sub"))
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
    }
    func RSquareButton(_ w: CGFloat, _ h: CGFloat) -> some View {
        self
            .foregroundColor(Color.white)
            .font(Font.custom("NotoSansKR-Medium", size: 15))
            .frame(width: w, height: h)
            .background(Color("Accent").cornerRadius(10))
    }
    
    func DisabledRSquareButton(_ w: CGFloat, _ h: CGFloat) -> some View {
        self
            .foregroundColor(Color.white)
            .font(Font.custom("NotoSansKR-Medium", size: 15))
            .frame(width: w, height: h)
            .background(Color("Gray4").cornerRadius(10))
    }
    
    func gray1() -> Text {
        self.foregroundColor(Color("Gray1"))
    }
    
    func gray2() -> Text {
        self.foregroundColor(Color("Gray2"))
    }
    
    func gray3() -> Text {
        self.foregroundColor(Color("Gray3"))
    }
    
    func gray4() -> Text {
        self.foregroundColor(Color("Gray4"))
    }
    
    func gray5() -> Text {
        self.foregroundColor(Color("Gray5"))
    }
    
    func gray6() -> Text {
        self.foregroundColor(Color("Gray6"))
    }
    
    func gray7() -> Text {
        self.foregroundColor(Color("Gray7"))
    }
}
