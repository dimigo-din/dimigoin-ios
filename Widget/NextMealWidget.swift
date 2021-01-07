//
//  NextMealWidget.swift
//  WidgetExtension
//
//  Created by 변경민 on 2020/10/21.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct NextMealWidget: View {
    var data: WidgetEntry
    var body: some View {
        ZStack {
            Image(data.tokenExist == false ? "dangermark" : "logo").resizable().aspectRatio(contentMode: .fit).frame(width: 60).opacity(0.25)
            GeometryReader { geometry in
                Rectangle().fill(Color(data.tokenExist == false ? "red" : "accent")).frame(width: 4, height: geometry.size.height)
            }
            if(data.tokenExist == true) {
                VStack {
                    HStack {
                        switch getMealType(){
                        case .breakfast : Text("아침").accent().font(Font.custom("NotoSansKR-Bold", size: 16))
                        case .lunch : Text("점심").accent().font(Font.custom("NotoSansKR-Bold", size: 16))
                        case .dinner : Text("저녁").accent().font(Font.custom("NotoSansKR-Bold", size: 16))
                        }
                        Spacer()
                        Text(getDateString()).font(Font.custom("NotoSansKR-Medium", size: 10)).gray4()
                    }
                    switch getMealType(){
                    case .breakfast : Text(data.breakfast).caption3()
                    case .lunch : Text(data.lunch).caption3()
                    case .dinner : Text(data.dinner).caption3()
                    }
                }.padding(.horizontal)
            } else {
                Text("사용자 정보가 동기화 되지 않았습니다. 앱을 실행하여 로그인 하거나 이미 로그인을 완료했다면 잠시만 기다려주세요.😉").caption3().padding(.horizontal)
            }
        }
    }
}

