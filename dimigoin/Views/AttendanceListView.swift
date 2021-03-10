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
    @EnvironmentObject var alertManager: AlertManager
    @State var searchText: String = ""
    @State var showDetailView: Bool = false
    @State var showHistoryView: Bool = false
    @State var selectedAttendance: Attendance = Attendance()
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = UIColor(Color.accent)
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView {
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(getStringTimeZone()).notoSans(.bold, size: 13, Color.gray4)
                            HStack {
                                Text("자습 현황").notoSans(.black, size: 30)
                                Spacer()
                                if api.user.type == .teacher {
                                    Button(action: {
                                        withAnimation(.spring()) {
                                            self.showHistoryView = true
                                        }
                                    }) {
                                        Text("히스토리")
                                            .notoSans(.bold, size: 12, Color.white)
                                            .frame(width: 74, height: 25)
                                            .background(Color.accent.cornerRadius(13))
                                    }
                                }
                            }
                        }
                    }.horizonPadding()
                    AttendanceChart(attendanceList: $api.attendanceList, geometry: geometry)
                    VSpacer(20)
                    SearchBar(searchText: $searchText, geometry: geometry)
                    VSpacer(25)
                    AttendanceList(attendanceList: $api.attendanceList,
                                   userType: api.user.type,
                                   searchText: $searchText,
                                   selectedAttendance: $selectedAttendance,
                                   showDetailView: $showDetailView,
                                   geometry: geometry)
                        .environmentObject(alertManager)
                    VSpacer(10)
                }
            }
            AttendanceDetailView(isShowing: $showDetailView, attendance: $selectedAttendance)
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                api.fetchAttendanceListData { }
            }) {
                Image(systemName: "arrow.triangle.2.circlepath")
            }
        )
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
    @Binding var attendanceList: [Attendance]
    var geometry: GeometryProxy
    func getAttendanceCountByPlaceType(placeType: PlaceType) -> Int {
//        api.attendanceList.filter { $0.attendanceLog[0].place.type == placeType }.count
        switch placeType {
        case .classroom: return attendanceList.filter { !$0.isRegistered }.count + attendanceList.filter { $0.isRegistered }.filter { $0.attendanceLog[0].place.type == .classroom }.count
        case .etc:
            return attendanceList.filter { $0.isRegistered }.filter { $0.attendanceLog[0].place.type == .etc }.count
        case .circle:
            return attendanceList.filter { $0.isRegistered }.filter { $0.attendanceLog[0].place.type == .circle }.count
        case .ingang:
            return attendanceList.filter { $0.isRegistered }.filter { $0.attendanceLog[0].place.type == .ingang }.count
        }
    }
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                RoundSquare(topLeft: 5, topRight: 5, bottomLeft: 0, bottomRight: 0).fill(Color.accent).frame(height: 35)
                Spacer()
            }.addBorder(Color.accent, width: 1, cornerRadius: 5)
            HStack {
                VStack {
                    Text("교실").notoSans(.bold, size: 13, Color.white)
                    VSpacer(12)
                    Text("\(getAttendanceCountByPlaceType(placeType: .classroom))")
                        .notoSans(.bold, size: 13, Color.accent)
                }
                Spacer()
                VStack {
                    Text("인강실").notoSans(.bold, size: 13, Color.white)
                    VSpacer(12)
                    Text("\(getAttendanceCountByPlaceType(placeType: .ingang))")
                        .notoSans(.bold, size: 13, Color.accent)
                }
                Spacer()
                VStack {
                    Text("동아리실").notoSans(.bold, size: 13, Color.white)
                    VSpacer(12)
                    Text("\(getAttendanceCountByPlaceType(placeType: .circle))")
                        .notoSans(.bold, size: 13, Color.accent)
                }
                Spacer()
                VStack {
                    Text("기타").notoSans(.bold, size: 13, Color.white)
                    VSpacer(12)
                    Text("\(getAttendanceCountByPlaceType(placeType: .etc))")
                        .notoSans(.bold, size: 13, Color.accent)
                }
                Spacer()
                VStack {
                    Text("총원").notoSans(.bold, size: 13, Color.white)
                    VSpacer(12)
                    Text("\(attendanceList.count)").notoSans(.bold, size: 13, Color.accent)
                }
            }.horizonPadding()
        }.horizonPadding()
        .frame(height: 70)
    }
}

struct AttendanceList: View {
    @EnvironmentObject var alertManager: AlertManager
    @Binding var attendanceList: [Attendance]
    @State var userType: UserType
    @Binding var searchText: String
    @Binding var selectedAttendance: Attendance
    @Binding var showDetailView: Bool
    var geometry: GeometryProxy

    var body: some View {
        VStack(spacing: 13) {
            ForEach(attendanceList.filter {
                self.searchText.isEmpty ? true : $0.name.contains(self.searchText)
            }, id: \.self) { attendance in
                AttendanceListItem(attendance: attendance,
                                   selectedAttendance: $selectedAttendance,
                                   showDetailView: $showDetailView,
                                   userType: $userType)
                    .environmentObject(alertManager)
            }
        }.horizonPadding()
        .frame(width: geometry.size.width)
        .animation(.spring())
    }
}

struct AttendanceListItem: View {
    @EnvironmentObject var alertManager: AlertManager
    @State var attendance: Attendance
    @Binding var selectedAttendance: Attendance
    @Binding var showDetailView: Bool
    @Binding var userType: UserType

    var body: some View {
        HStack {
            Text("\(String(format: "%02d", attendance.number))").notoSans(.bold, size: 15, Color.gray4)
            HSpacer(30)
            Text("\(attendance.name)").notoSans(.bold, size: 15, Color.gray4)
            Spacer()
            if attendance.isRegistered {
                PlaceBadge(place: attendance.attendanceLog[0].place)
                    .onTapGesture {
                        alertManager.createAlert("", sub: "", .attendance)
                    }
            } else {
                PlaceBadge(placeName: "\(attendance.grade)학년 \(attendance.klass)반", placeType: .classroom)
            }
            Spacer()
            if userType == .teacher {
                Button(action: {
                    self.selectedAttendance = attendance
                    withAnimation(.spring()) {
                        self.showDetailView = true
                    }
                }) {
                    Text("자세히보기")
                        .notoSans(.bold, size: 10, Color.systemBackground)
                        .frame(width: 74, height: 20)
                        .background(Color("gray6").cornerRadius(5))
                }
            } else {
                Text(attendance.isRegistered ? attendance.attendanceLog[0].time : "정보 없음".localized)
                    .notoSans(.bold, size: 10, Color.systemBackground)
                    .frame(width: 74, height: 20)
                    .background(Color("gray6").cornerRadius(5))
            }
            
        }.horizonPadding()
        .opacity(attendance.isRegistered ? 1 : 0.4)
    }
}

struct PlaceBadge: View {
    @State var place: Place
    @State var showFullPlaceName: Bool = false
    init(place: Place) {
        self._place = .init(initialValue: place)
    }
    init(placeName: String, placeType: PlaceType) {
        self._place = .init(initialValue: Place(id: "", label: "", name: placeName, location: "", type: placeType))
    }
    var body: some View {
        HStack(spacing: 0) {
            Image(getPlaceBadgeIcon(place.type)).templateImage(width: 10, Color.gray4)
                .padding(.leading, 8)
            HSpacer(11)
            Text(place.name).notoSans(.medium, size: 10, Color.gray4)
                .padding(.trailing, 13)
        }.frame(height: 20)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color("gray6"), lineWidth: 1)
        )
        .onTapGesture {
            withAnimation(.easeInOut) {
                self.showFullPlaceName.toggle()
            }
        }
    }
    func getPlaceBadgeIcon(_ placeType: PlaceType) -> String {
        switch placeType {
        case .circle: return "person.2"
        case .etc: return "etc"
        case .classroom: return "class"
        case .ingang: return "headphone"
        }
    }
}

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S: ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
             .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}
