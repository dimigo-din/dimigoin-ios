//
//  WidgetView.swift
//  Widget
//
//  Created by 변경민 on 2020/07/05.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct WidgetView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("아침").font(.headline).foregroundColor(Color("Primary"))
                    Spacer()
                    Text("닭다리삼계죽 | 보조밥 | 고기산적&케찹 | 호박버섯볶음 | 건새우마늘쫑볶음 | 깍두기 | 모듬과일 | 미니크라상&잼 | 푸딩").font(.caption)
                }
                HStack {
                    Text("점심").font(.headline).foregroundColor(Color("Primary"))
                    Spacer()
                    Text("라면&보조밥 | 소떡소떡 | 야끼만두&초간장 | 참나물만다린무침 | 단무지 | 포기김치 | 우유빙수").font(.caption)
                }
                HStack {
                    Text("저녁").font(.headline).foregroundColor(Color("Primary"))
                    Spacer()
                    Text("김치참치마요덮밥 | 쌀밥 | 콩나물국 | 치즈스틱 | 실곤약치커리무침 | 깍두기 | 미니딸기파이").font(.caption)
                }
            }.padding()
        }
        
    }
}
