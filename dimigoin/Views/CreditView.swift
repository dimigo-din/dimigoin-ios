//
//  CreditView.swift
//  dimigoin
//
//  Created by 변경민 on 2021/01/10.
//  Copyright © 2021 seohun. All rights reserved.
//


// 디미고인 여러분들 너무너무 수고했어요 ~

import SwiftUI
import DimigoinKit

var skinOptions: [RadioOption] = [
    RadioOption(idx: 0, label: "마젠타(기본)", value: "accent"),
    RadioOption(idx: 1, label: "레드", value: "red"),
    RadioOption(idx: 2, label: "그린", value: "green"),
    RadioOption(idx: 3, label: "블루", value: "blue"),
    RadioOption(idx: 4, label: "오렌지", value: "orange"),
    RadioOption(idx: 5, label: "옐로우", value: "yellow")
]

struct CreditView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 10){
                    RadioList(options: skinOptions, title: "테마 컬러", footer: "테마 컬러는 앱, 위젯에 적용되며 선택 후 다시시작해야 적용됩니다.", geometry: geometry)
                    ToggleOption(title: "숨겨진 기능", footer: "", geometry: geometry)
                }
            }
        }
        .navigationBarTitle("디미고인🤗")
    }
}

struct RadioOption: Hashable {
    var idx: Int
    var label: String
    var value: String
}

struct RadioList: View {
    @State var selected : Int = 0
    var options: [RadioOption]
    var title: String
    var footer: String
    var geometry: GeometryProxy
    
    init(options: [RadioOption], footer: String, geometry: GeometryProxy) {
        self.options = options
        for i in 0..<options.count {
            if(getAccentColor() == options[i].value) {
                self._selected = .init(initialValue: options[i].idx)
            }
        }
        self.geometry = geometry
        self.title = ""
        self.footer = footer
    }
    
    init(options: [RadioOption], title: String, footer: String, geometry: GeometryProxy) {
        self.options = options
        for i in 0..<options.count {
            if(getAccentColor() == options[i].value) {
                self._selected = .init(initialValue: options[i].idx)
            }
        }
        self.geometry = geometry
        self.title = title
        self.footer = footer
    }
    
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Text(title).caption2().padding(.leading)
                Spacer()
            }
            Divider().foregroundColor(Color.divider)
            ForEach(options, id: \.self) { option in
                RadioButton(selected: $selected, option: option, geometry: geometry)
                Divider().foregroundColor(Color.divider)
            }
            HStack {
                Text(footer).gray4().caption3().padding(.leading)
                Spacer()
            }
        }.frame(alignment: .leading)
        
    }
}

struct RadioButton: View {
    @Binding var selected: Int
    var option: RadioOption
    var geometry: GeometryProxy
    var body: some View {
        HStack {
            Text(option.label).font(Font.custom("NotoSansKR-Regular", size: 15))
            Spacer()
            ZStack {
                
                Circle()
                    .strokeBorder(Color("gray3"),lineWidth: 1)
                    .frame(width: 26, height: 26)
                Circle()
                    .fill(Color.accent)
                    .frame(width: selected == option.idx ? 26 : 0, height: selected == option.idx ? 26 : 0)
                
                Circle()
                    .fill(Color(UIColor.systemBackground))
                    .frame(width: 12, height: 12)
            }
        }
        .padding(.horizontal)
        .frame(width: geometry.size.width, height: 50)
        .background(Color.accent.opacity(selected == option.idx ? 0.05 : 0))
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.spring()) {
                self.selected = option.idx
            }
            setAccentColor(option.value)
        }
        
    }
}

struct ToggleOption: View {
    var title: String
    var footer: String
    var geometry: GeometryProxy
    
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Text(title).caption2().padding(.leading)
                Spacer()
            }
            Divider().foregroundColor(Color.divider)
            HStack {
                Text("모든 반 시간표 조회")
                Spacer()
                SimpleToggle()
            }.padding(.horizontal)
            .frame(width: geometry.size.width, height: 50)
            .contentShape(Rectangle())
            Divider().foregroundColor(Color.divider)
            HStack {
                Text(footer).gray4().caption3().padding(.leading)
                Spacer()
            }
        }.frame(alignment: .leading)
        
    }
}

struct SimpleToggle: View {
    @State var isOn: Bool = false
    @State var isMagicRevealed: Bool = UserDefaults.standard.bool(forKey: "Magic") == true ? true : false
    init() {
        self._isOn = .init(initialValue: isMagicRevealed)
    }
    var body: some View {
        ZStack {
            Capsule()
                .strokeBorder(Color.accent,lineWidth: 1.5)
                .frame(width: 48, height: 26)
            if isOn {
                Capsule()
                    .fill(Color.accent)
                    .frame(width: 48, height: 26)
            }
            Circle().frame(width: 20, height: 20)
                .foregroundColor(isOn ? Color(UIColor.systemBackground) : Color.accent)
                .offset(x: isOn ? 10 : -10)
        }.onTapGesture {
            withAnimation(.spring()) {
                self.isOn.toggle()
            }
            if isOn {
                UserDefaults.standard.setValue(true, forKey: "Magic")
            }
            else {
                UserDefaults.standard.setValue(false, forKey: "Magic")
            }
        }
    }
}
