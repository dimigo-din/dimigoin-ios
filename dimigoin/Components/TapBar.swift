//
//  TapBar.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

public var tabBarSize: CGFloat = UIDevice.current.hasNotch ? 74 : 64

struct TapBarItem: Hashable {
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
    @Binding var isShowIdCard: Bool
    @Binding var isFetching: Bool
    var tapBarItems: [TapBarItem] = [
        TapBarItem(idx: 0, icon: "idcard", label: "학생증", identifier: "tapbar.idcard"),
        TapBarItem(idx: 1, icon: "headphone", label: "인강실", identifier: "tapbar.ingang"),
        TapBarItem(idx: 2, icon: "home", activatedIcon: "home.fill", label: "메인", identifier: "tapbar.home"),
        TapBarItem(idx: 3, icon: "meal", label: "급식표", identifier: "tapbar.meal"),
        TapBarItem(idx: 4, icon: "calendar", activatedIcon: "calendar.fill", label: "시간표", identifier: "tapbar.timetable")
    ]
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 45) {
                ForEach(tapBarItems, id: \.self) { item in
                    TapBarButton(index: $index, item: item)
                }
            }.frame(height: tabBarSize)
            .horizonPadding()
            if UIDevice.current.hasNotch {
                VSpacer(10)
            }
        }.frame(height: tabBarSize)
        .frame(maxWidth: .infinity)
        .background(Rectangle().fill(Color.systemBackground).shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0).edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
        .offset(y: isShowIdCard || isFetching ? tabBarSize : 0)
    }
}

struct TapBarButton: View {
    @Binding var index: Int
    var item: TapBarItem
    var body: some View {
        Button(action: {
            withAnimation(.interactiveSpring()) {
                self.index = item.idx
            }
        }) {
            VStack {
                if self.index == item.idx {
                    Image(item.activatedIcon)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: item.icon == "idcard" ? 18 : 24)
                        .foregroundColor(self.index == item.idx ? Color.accent : Color("gray7"))
                        .padding(.top, item.icon == "idcard" ? 3 : 0)
                } else {
                    Image(item.icon)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: item.icon == "idcard" ? 18 : 24)
                        .foregroundColor(self.index == item.idx ? Color.accent : Color("gray7"))
                        .padding(.top, item.icon == "idcard" ? 3 : 0)
                }
                
                VSpacer(item.icon == "idcard" ? 11.8 : 7.8)
                
                Text(item.label)
                    .nanumSquare(.extraBold, size: 10)
                    .foregroundColor(self.index == item.idx ? Color.accent : Color("gray7"))
            }
        }.accessibility(identifier: item.identifier)
    }
}

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
