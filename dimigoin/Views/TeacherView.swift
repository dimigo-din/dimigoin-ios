//
//  TeacherView.swift
//  dimigoin
//
//  Created by 변경민 on 2021/02/18.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct TeacherView: View {
    @EnvironmentObject var api: DimigoinAPI
    @State var searchText: String = ""
    @State var showDetailView: Bool = false
    @State var showHistoryView: Bool = false
    @State var selectedAttendance: Attendance = Attendance()
    
    @State var selectedGrade: Int = 1
    @State var selectedClass: Int = 1
    
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView {
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(getStringTimeZone()).notoSans(.bold, size: 13, Color.gray4)
                            HStack {
                                Text("\(selectedGrade)학년 \(selectedClass)반").notoSans(.black, size: 30)
                                Spacer()
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
                    }.horizonPadding()
                    .padding(.top, 30)
                    AttendanceChart(api: api, geometry: geometry)
                    VSpacer(20)
                    SearchBar(searchText: $searchText, geometry: geometry)
                    VSpacer(25)
                    AttendanceList(api: api, searchText: $searchText,
                                   selectedAttendance: $selectedAttendance,
                                   showDetailView: $showDetailView,
                                   geometry: geometry)
                    VSpacer(10)
                }
            }
            AttendanceDetailView(isShowing: $showDetailView, attendance: $selectedAttendance)
            AttendanceHistoryView(isShowing: $showHistoryView)
                .environmentObject(api)
            VStack {
                Spacer()
                VStack {
                    Picker("반을 선택해주세요", selection: $selectedGrade) {
                        ForEach(1..<4, id: \.self) { grade in
                            Text("\(grade)학년")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .horizonPadding()
                    VSpacer(5)
                    Picker("교실을 선택해주세요", selection: $selectedClass) {
                        ForEach(1..<7, id: \.self) { klass in
                            Text("\(klass)반")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .horizonPadding()
                }.frame(height: 120)
                .frame(maxWidth: .infinity)
                .background(
                    RoundSquare(topLeft: 10, topRight: 10, bottomLeft: 0, bottomRight: 0)
                        .fill(Color.systemBackground)
                        .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0)
                        .edgesIgnoringSafeArea(.all)
                )
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

//struct AttendanceChart: View {
//    @State var attendanceList:[Attendance]
//    var geometry: GeometryProxy
//
//    var body: some View {
//        ZStack {
//            VStack(spacing: 0) {
//                RoundSquare(topLeft: 5, topRight: 5, bottomLeft: 0, bottomRight: 0).fill(Color.accent).frame(height: 35)
//                Spacer()
//            }.addBorder(Color.accent, width: 1, cornerRadius: 5)
//            HStack {
//                VStack {
//                    Text("교실").notoSans(.bold, size: 13, Color.white)
//                    VSpacer(12)
//                    Text("\(attendanceList.filter { $0.attendanceLog[0].type == .classroom }.count)")
//                        .notoSans(.bold, size: 13, Color.accent)
//                }
//                Spacer()
//                VStack {
//                    Text("인강실").notoSans(.bold, size: 13, Color.white)
//                    VSpacer(12)
//                    Text("\(attendanceList.filter { $0.attendanceLog[0].type == .ingang }.count)")
//                        .notoSans(.bold, size: 13, Color.accent)
//                }
//                Spacer()
//                VStack {
//                    Text("동아리").notoSans(.bold, size: 13, Color.white)
//                    VSpacer(12)
//                    Text("\(attendanceList.filter { $0.attendanceLog[0].type == .circle }.count)")
//                        .notoSans(.bold, size: 13, Color.accent)
//                }
//                Spacer()
//                VStack {
//                    Text("기타").notoSans(.bold, size: 13, Color.white)
//                    VSpacer(12)
//                    Text("\(attendanceList.filter { $0.attendanceLog[0].type == .etc }.count)")
//                        .notoSans(.bold, size: 13, Color.accent)
//                }
//                Spacer()
//                VStack {
//                    Text("총원").notoSans(.bold, size: 13, Color.white)
//                    VSpacer(12)
//                    Text("\(attendanceList.count)").notoSans(.bold, size: 13, Color.accent)
//                }
//            }.horizonPadding()
//        }.horizonPadding()
//        .frame(height: 70)
//    }
//}
//
//struct AttendanceList: View {
//    @State var api: DimigoinAPI
//    @Binding var searchText: String
//    @Binding var selectedAttendance: Attendance
//    @Binding var showDetailView: Bool
//    var geometry: GeometryProxy
//
//    var body: some View {
//        VStack(spacing: 13) {
//            ForEach(api.attendanceList.filter {
//                self.searchText.isEmpty ? true : ($0.name.contains(self.searchText) || $0.attendanceLog[0].label.contains(self.searchText))
//            }, id: \.self) { attendance in
//                AttendanceListItem(attendance: attendance,
//                                   selectedAttendance: $selectedAttendance,
//                                   showDetailView: $showDetailView)
//            }
//        }.horizonPadding()
//        .frame(width: geometry.size.width)
//        .animation(.spring())
//    }
//}
