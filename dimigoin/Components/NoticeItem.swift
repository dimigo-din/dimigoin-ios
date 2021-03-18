//
//  NoticeItem.swift
//  dimigoin
//
//  Created by 변경민 on 2021/02/26.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct NoticeItem: View {
    @EnvironmentObject var api: DimigoinAPI
    @State var geometry: GeometryProxy
    @State var gradientColors: [Color] = [
        Color.systemBackground.opacity(0),
        Color.systemBackground.opacity(1)
    ]
    var body: some View {
        if api.notices.count != 0 {
                ScrollView(showsIndicators: false) {
                    Text("\(api.notices[0].content)")
                        .notoSans(.regular, size: 12, .gray4)
                        .lineSpacing(6)
                    VSpacer(20)
                }.padding([.horizontal, .top], 20)
                .frame(width: geometry.size.width-40, height: 170, alignment: .top)
                .addBorder(Color.divider, width: 1, cornerRadius: 10)
        }
    }
}
