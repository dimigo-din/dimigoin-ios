//
//  AttendanceListView.swift
//  dimigoin
//
//  Created by 변경민 on 2021/01/30.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct AttendanceListView: View {
    @EnvironmentObject var api: DimigoinAPI
    @State var searchText: String = ""
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                HStack {
                    VStack(alignment: .leading, spacing: 0){
                        Text(getStringTimeZone()).subTitle()
                        Text("자습 현황").title()
                    }
                    Spacer()
                    Image("class").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(height: 35).foregroundColor(Color.accent)
                }.horizonPadding()
                HDivider().horizonPadding().offset(y: -15)
                VSpacer(10)
                AttendanceChart(api: api, geometry: geometry)
                SearchBar(searchText: $searchText, geometry: geometry)
                AttendanceList(api: api, searchText: $searchText, geometry: geometry)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}
struct SearchBar: View {
    @Binding var searchText: String
    var geometry: GeometryProxy
    var body: some View {
        TextField("이름으로 검색하기", text: $searchText).textContentType(.none)
            .font(Font.custom("NanumSquareR", size: 14))
            .padding(.leading)
            .frame(width: geometry.size.width-40, height: 38)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("gray6"), lineWidth: 1)
            )
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .modifier(SearchBarClearButton(text: $searchText))
    }
}

struct AttendanceChart: View {
    @State var api: DimigoinAPI
    var geometry: GeometryProxy

    var body: some View {
        Text("chart")
    }
}

struct AttendanceList: View {
    @State var api: DimigoinAPI
    @Binding var searchText: String
    var geometry: GeometryProxy

    var body: some View {
        VStack {
            ForEach(api.attendances.filter {
                self.searchText.isEmpty ? true : ($0.name.contains(self.searchText) || $0.currentLocation.label.contains(self.searchText))
            }, id: \.self) { attendance in
                AttendanceListItem(attendance: attendance, geometry: geometry)
            }
        }.animation(.spring())
    }
}

struct AttendanceListItem: View {
    @State var attendance: Attendance
    var geometry: GeometryProxy
    
    var body: some View {
        Text("\(attendance.name) \(attendance.currentLocation.label)")
    }
}
