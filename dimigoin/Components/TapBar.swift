//
//  TapBar.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct tapBarItem: Hashable {
    var idx: Int
    var icon: String
    var label: String
    var identifier: String
}

struct TapBar: View {
    @Binding var index: Int
    var tapBarItems: [tapBarItem] = [
        tapBarItem(idx: 0, icon: "doc", label: "내정보", identifier: "tapbar.mypage"),
        tapBarItem(idx: 1, icon: "headphone", label: "인강실", identifier: "tapbar.ingang"),
        tapBarItem(idx: 2, icon: "home", label: "메인", identifier: "tapbar.home"),
        tapBarItem(idx: 3, icon: "etc", label: "급식", identifier: "tapbar.meal"),
        tapBarItem(idx: 4, icon: "calendar", label: "시간표", identifier: "tapbar.timetable")
    ]
    
    var body: some View {
        VStack {
            HDivider()
            HStack(spacing: 50) {
                ForEach(tapBarItems, id: \.self) { item in
                    Button(action: {
                        self.index = item.idx
                    }) {
                        VStack {
                            Image(item.icon)
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 24)
                                .foregroundColor(self.index == item.idx ? Color("accent") : Color("gray3"))
                            VSpacer(7.8)
                            Text(item.label)
                                .tapBarItem()
                                .foregroundColor(self.index == item.idx ? Color("accent") : Color("gray3"))
                        }
                    }.accessibility(identifier: item.identifier)
                }
            }
            .animation(.spring())
        }.edgesIgnoringSafeArea(.all)
    }
}
