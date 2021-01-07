//
//  TextStyles.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/07/04.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

extension Text {
    
    /// 마젠타색으로 강조
    func accent() -> Text {
        self.foregroundColor(Color("accent"))
    }
    
    /// 빨간색 린팅
    func warning() -> Text {
        self.foregroundColor(Color("red"))
    }
    /// Sub 색 린팅
    func sub() -> Text {
        self.foregroundColor(Color("sub"))
    }
    
    /// NanumSquareEB, 10
    func tapBarItem() -> Text {
        self.font(Font.custom("NanumSquareEB", size: 10))
    }
    
    /// "disabled"
    func disabled() -> Text {
        self.foregroundColor(Color("disabled"))
    }
    
    ///NotoSansKR-Black, 40
    func title() -> Text {
        self.font(Font.custom("NotoSansKR-Black", size: 40))
    }
    
    /// "gray4", NotoSansKR-Bold, 13
    func subTitle() -> Text {
        self
            .foregroundColor(Color("gray4"))
            .font(Font.custom("NotoSansKR-Bold", size: 13))
    }
    
    /// accent, NotoSansKR-Bold, 10
    func subSectionHeader() -> Text {
        self
            .foregroundColor(Color("accent"))
            .font(Font.custom("NotoSansKR-Bold", size: 10))
    }
    
    /// NotoSansKR-Bold, 21
    func sectionHeader() -> Text {
        self.font(Font.custom("NotoSansKR-Bold", size: 21))
    }
    
    /// lineSpacing(12), gray2, NotoSansKR-Regular, 12
    func mealMenu() -> some View {
        self
            .lineSpacing(12)
            .foregroundColor(Color("gray2"))
            .font(Font.custom("NotoSansKR-Regular", size: 12))
            
    }
    /// lineSpacing(12), black, NotoSansKR-Medium, 14
    func noticeTitle() -> some View {
        self
            .lineSpacing(12)
            .foregroundColor(Color.black)
            .font(Font.custom("NotoSansKR-Medium", size: 14))
            
    }
    /// lineSpacing(12), gray2, NotoSansKR-Regular, 12
    func noticeContent() -> some View {
        self
            .lineSpacing(12)
            .foregroundColor(Color("gray2"))
            .font(Font.custom("NotoSansKR-Regular", size: 12))
            
    }
    
    
    /// color, NotoSansKR-Bold, 15
    func alertTitle(_ color: Color) -> some View {
        self
            .foregroundColor(color)
            .font(Font.custom("NotoSansKR-Bold", size: 15))
    }
    
    /// gray2, NotoSansKR-Regular, 11
    func alertSubTitle() -> some View {
        self
            .foregroundColor(Color("gray2"))
            .font(Font.custom("NotoSansKR-Regular", size: 11))
    }
    
    /// gray4, NotoSansKR-Bold, 17
    func alertButton() -> some View {
        self
            .foregroundColor(Color("gray4"))
            .font(Font.custom("NotoSansKR-Bold", size: 17))
    }
    
    /// NotoSansKR-Regular, 15
    func body() -> Text {
        self.font(Font.custom("NotoSansKR-Regular", size: 15))
    }
    
    /// NotoSansKR-Medium, 16
    func infoText() -> Text {
        self.font(Font.custom("NotoSansKR-Medium", size: 16))
    }
    
    /// Openas, 57
    func logoFont() -> Text {
        self.font(Font.custom("Openas", size: 57)).foregroundColor(Color("text.logo"))
    }
    
    /// .heavy
    func heavy() -> Text {
        self.fontWeight(.heavy)
    }
    
    /// .black
    func black() -> Text {
        self.fontWeight(.black)
    }
    
    /// NotoSansKR-Bold, 12
    func caption1() -> Text {
        self.font(Font.custom("NotoSansKR-Bold", size: 12))
    }
    
    /// NotoSansKR-Regular, 13
    func caption2() -> Text {
        self.font(Font.custom("NotoSansKR-Regular", size: 13))
    }
    
    /// NotoSansKR-Regular, 11
    func caption3() -> Text {
        self.font(Font.custom("NotoSansKR-Regular", size: 11))
    }
    
    func SquareButton(_ w:CGFloat, _ h:CGFloat) -> some View {
        self
            .font(Font.custom("NotoSansKR-Bold", size: 18))
            .frame(width: w, height: h)
            .padding()
            .background(Color("accent"))
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
    }
    
    func DisabledSquareButton(_ w:CGFloat, _ h:CGFloat) -> some View {
        self
            .font(Font.custom("NotoSansKR-Bold", size: 17))
            .frame(width: w, height: h)
            .padding()
            .background(Color("sub"))
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
    }
    func RSquareButton(_ w: CGFloat, _ h: CGFloat) -> some View {
        self
            .foregroundColor(Color.white)
            .font(Font.custom("NotoSansKR-Medium", size: 15))
            .frame(width: w, height: h)
            .background(Color("accent").cornerRadius(10))
    }
    
    func DisabledRSquareButton(_ w: CGFloat, _ h: CGFloat) -> some View {
        self
            .foregroundColor(Color.white)
            .font(Font.custom("NotoSansKR-Medium", size: 15))
            .frame(width: w, height: h)
            .background(Color("gray4").cornerRadius(10))
    }
    
    func gray1() -> Text {
        self.foregroundColor(Color("gray1"))
    }
    
    func gray2() -> Text {
        self.foregroundColor(Color("gray2"))
    }
    
    func gray3() -> Text {
        self.foregroundColor(Color("gray3"))
    }
    
    func gray4() -> Text {
        self.foregroundColor(Color("gray4"))
    }
    
    func gray5() -> Text {
        self.foregroundColor(Color("gray5"))
    }
    
    func gray6() -> Text {
        self.foregroundColor(Color("gray6"))
    }
    
    func gray7() -> Text {
        self.foregroundColor(Color("gray7"))
    }
}
