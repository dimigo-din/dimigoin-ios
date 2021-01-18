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
    var activatedIcon: String
    var label: String
    var identifier: String
    
    init(idx: Int, icon: String, activatedIcon: String, label: String, identifier: String) {
        self.idx = idx
        self.icon = icon
        self.activatedIcon = activatedIcon
        self.label = label
        self.identifier = identifier
    }
    
    init(idx: Int, icon: String, label: String, identifier: String) {
        self.idx = idx
        self.icon = icon
        self.activatedIcon = icon
        self.label = label
        self.identifier = identifier
    }
}

struct TapBar: View {
    @Binding var index: Int
    var tapBarItems: [tapBarItem] = [
        tapBarItem(idx: 0, icon: "idcard", label: "학생증", identifier: "tapbar.idcard"),
        tapBarItem(idx: 1, icon: "headphone", label: "인강실", identifier: "tapbar.ingang"),
        tapBarItem(idx: 2, icon: "home", activatedIcon: "home.fill", label: "메인", identifier: "tapbar.home"),
        tapBarItem(idx: 3, icon: "meal", label: "급식표", identifier: "tapbar.meal"),
        tapBarItem(idx: 4, icon: "calendar", activatedIcon: "calendar.fill", label: "시간표", identifier: "tapbar.timetable")
    ]
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 45) {
                ForEach(tapBarItems, id: \.self) { item in
                    TapBarButton(index: $index, item: item)
                }
            }.frame(height: 74)
            .padding(.bottom)
            .horizonPadding()
        }.frame(height: 74)
        .frame(maxWidth: .infinity)
        .background(Rectangle().fill(Color.systemBackground).shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0).edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}

struct TapBarButton: View {
    @Binding var index: Int
    var item: tapBarItem
    var body: some View {
        Button(action: {
            self.index = item.idx
        }) {
            VStack {
                if self.index == item.idx {
                    Image(item.activatedIcon)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: item.icon == "meal" ? 15 : 24)
                        .foregroundColor(self.index == item.idx ? Color.accent : Color("gray7"))
                }
                else {
                    Image(item.icon)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: item.icon == "meal" ? 15 : 24)
                        .foregroundColor(self.index == item.idx ? Color.accent : Color("gray7"))
                }
                VSpacer(7.8)
                Text(item.label)
                    .tapBarItem()
                    .foregroundColor(self.index == item.idx ? Color.accent : Color("gray7"))
            }
        }.accessibility(identifier: item.identifier)
    }
}
