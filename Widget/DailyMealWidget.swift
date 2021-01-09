//
//  DailyMealWidget.swift
//  dimigoin
//
//  Created by 변경민 on 2020/10/21.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct DailyMealWidget: View {
    var data: WidgetEntry
    var body: some View {
        ZStack {
            Image(data.tokenExist == false ? "dangermark" : "logo").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(width: 60).foregroundColor(data.tokenExist == false ? Color("red") : Color.accent)
                .opacity(data.tokenExist == false ? 0.4 : 0.25)
            GeometryReader { geometry in
                Rectangle().fill(data.tokenExist == false ? Color("red") : Color.accent)
                    .frame(width: 4, height: data.tokenExist == false ? geometry.size.height : geometry.size.height/3)
                    .offset(y: getMealType() == .lunch ? geometry.size.height/3 : (getMealType() == .dinner ? geometry.size.height*2/3 : 0))
            }
            if(data.tokenExist == true) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack{
                        Text("아침").accent().font(Font.custom("NotoSansKR-Bold", size: 16))
                        Text("\(data.breakfast)").font(Font.custom("NotoSansKR-Regular", size: 10))
                    }
                    HStack {
                        Text("점심").accent().font(Font.custom("NotoSansKR-Bold", size: 16))
                        Text("\(data.lunch)").font(Font.custom("NotoSansKR-Regular", size: 10))
                    }
                    HStack {
                        Text("저녁").accent().font(Font.custom("NotoSansKR-Bold", size: 16))
                        Text("\(data.dinner)").font(Font.custom("NotoSansKR-Regular", size: 10))
                    }
                }.padding(.horizontal)
            } else {
                Text("사용자 정보가 동기화 되지 않았습니다. 앱을 실행하여 로그인 하거나 이미 로그인을 완료했다면 잠시만 기다려주세요.😉").caption3().padding(.horizontal)
            }
        }
    }
}

