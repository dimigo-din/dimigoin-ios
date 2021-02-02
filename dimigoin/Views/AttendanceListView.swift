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
                    VStack(alignment: .leading, spacing: 0) {
                        Text(getStringTimeZone()).notoSans(.bold, size: 13, Color.gray4)
                        Text("자습 현황").notoSans(.black, size: 30)
                    }
                    Spacer()
                    Image("class").templateImage(height: 35, Color.accent)
                }.horizonPadding()
                HDivider().horizonPadding().offset(y: -15)
                AttendanceChart(api: api, geometry: geometry)
                VSpacer(15)
                SearchBar(searchText: $searchText, geometry: geometry)
                VSpacer(15)
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
        ZStack {
            VStack(spacing: 0) {
                RoundSquare(topLeft: 5, topRight: 5, bottomLeft: 0, bottomRight: 0).fill(Color.accent).frame(height: 35)
                Spacer()
            }.addBorder(Color.accent, width: 1, cornerRadius: 5)
            HStack {
                VStack {
                    Text("교실").notoSans(.bold, size: 15, Color.white)
                    VSpacer(12)
                    Text("0").notoSans(.bold, size: 15, Color.accent)
                }
                Spacer()
                VStack {
                    Text("인강실").notoSans(.bold, size: 15, Color.white)
                    VSpacer(12)
                    Text("0").notoSans(.bold, size: 15, Color.accent)
                }
                Spacer()
                VStack {
                    Text("동아리").notoSans(.bold, size: 15, Color.white)
                    VSpacer(12)
                    Text("0").notoSans(.bold, size: 15, Color.accent)
                }
                Spacer()
                VStack {
                    Text("기타").notoSans(.bold, size: 15, Color.white)
                    VSpacer(12)
                    Text("0").notoSans(.bold, size: 15, Color.accent)
                }
                Spacer()
                VStack {
                    Text("총원").notoSans(.bold, size: 15, Color.white)
                    VSpacer(12)
                    Text("\(api.attendanceList.count)").notoSans(.bold, size: 15, Color.accent)
                }
            }.horizonPadding()
        }.horizonPadding()
        .frame(height: 70)
    }
}

struct AttendanceList: View {
    @State var api: DimigoinAPI
    @Binding var searchText: String
    var geometry: GeometryProxy

    var body: some View {
        VStack(spacing: 13) {
            ForEach(api.attendanceList.filter {
                self.searchText.isEmpty ? true : ($0.name.contains(self.searchText) || $0.currentLocation.label.contains(self.searchText))
            }, id: \.self) { attendance in
                AttendanceListItem(attendance: attendance)
            }
        }.horizonPadding()
        .frame(width: geometry.size.width)
        .animation(.spring())
    }
}

struct AttendanceListItem: View {
    @State var attendance: Attendance
    
    var body: some View {
        HStack {
            Text("\(String(format: "%02d", attendance.number))").notoSans(.bold, size: 16, Color.gray4)
            Spacer()
            Text("\(attendance.name)").notoSans(.bold, size: 16, Color.gray4)
            Spacer()
            PlaceBadge(place: attendance.currentLocation)
            Spacer()
            NavigationLink(destination: AttendanceDetailView(attendance: attendance)) {
                Text("자세히보기")
                    .notoSans(.bold, size: 10, Color.white)
                    .frame(width: 74, height: 20)
                    .background(Color("gray6").cornerRadius(5))
            }
        }.horizonPadding()
    }
}

struct PlaceBadge: View {
    @State var place: Place
    
    var body: some View {
        HStack {
            Text(place.type).notoSans(.medium, size: 11, Color.gray4)
        }.frame(width: 60, height: 20)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color("gray6"), lineWidth: 1)
        )
    }
}

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S: ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
             .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}
