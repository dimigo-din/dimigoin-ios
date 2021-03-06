//
//  AttendanceDetailView.swift
//  dimigoin
//
//  Created by 변경민 on 2021/02/02.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct AttendanceDetailView: View {
    @EnvironmentObject var api: DimigoinAPI
    @Binding var isShowing: Bool
    @Binding var attendance: Attendance
    @State var attendanceLog: [AttendanceLog] = []
    @State var isFetching: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all).opacity(isShowing ? 0.1 : 0)
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    ZStack {
                        VStack {
                            VSpacer(35)
                            Text("\(attendance.grade)학년 \(attendance.klass)반 \(attendance.number)번")
                                .notoSans(.bold, size: 10, Color.accent)
                            VSpacer(4)
                            Text("\(attendance.name)")
                                .notoSans(.bold, size: 20, Color.text)
                            VSpacer(14)
                            HStack {
                                VStack {
                                    Text("현재위치")
                                        .notoSans(.medium, size: 12, Color.gray4)
                                    VSpacer(7)
                                    if attendance.isRegistered {
                                        PlaceBadge(place: attendance.attendanceLog[0].place)
                                    } else {
                                        PlaceBadge(placeName: "\(attendance.grade)학년 \(attendance.klass)반", placeType: .classroom)
                                    }
                                }
                                HSpacer(64)
                                VStack {
                                    Text("등록시간")
                                        .notoSans(.medium, size: 12, Color.gray4)
                                    VSpacer(7)
                                    if attendance.isRegistered {
                                        Text(attendance.attendanceLog[0].time)
                                            .notoSans(.medium, size: 10, Color.gray4)
                                            .frame(width: 60, height: 20)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(Color("gray6"), lineWidth: 1)
                                            )
                                    } else {
                                        Text("미등록")
                                            .notoSans(.medium, size: 10, Color.gray4)
                                            .frame(width: 60, height: 20)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(Color("gray6"), lineWidth: 1)
                                            )
                                    }
                                }
                            }
                            VSpacer(30)
                            HDivider()
                            ScrollView {
                                VStack(spacing: 15) {
                                    if isFetching {
                                        ProgressView()
                                    } else {
                                        ForEach(0..<attendanceLog.count, id: \.self) { idx in
                                            Text("[ \(attendanceLog[idx].time) ] \(attendance.name)님이 자신의 현황을 ")
                                                .notoSans(.medium, size: 10, Color.gray4)
                                            +
                                            Text(attendanceLog[idx].place.name)
                                                .notoSans(.bold, size: 10, Color.accent)
                                            +
                                            Text("(으)로 \(idx == 0 ? "등록" : "변경")")
                                                .notoSans(.medium, size: 10, Color.gray4)
                                        }
                                    }
                                }.multilineTextAlignment(.leading)
                                .horizonPadding()
                                VSpacer(15)
                            }
                            .padding(.bottom, 45)
                        }
                        VStack {
                            Spacer()
                            Button(action: {
                                dismiss()
                            }) {
                                Text("닫기")
                                    .foregroundColor(Color.white)
                                    .notoSans(.bold, size: 14)
                                    .frame(height: 45)
                                    .frame(maxWidth: .infinity)
                                    .background(RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 10, bottomRight: 10).fill(Color.accent))
                            }
                        }
                    }
                }
                .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? abs(geometry.size.width - 80) : 295, height: 380)
                .background(Color(UIColor.systemBackground).cornerRadius(10))
                .edgesIgnoringSafeArea(.all)
                .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .phone ? 40 : (geometry.size.width - 295)/2)
                .padding(.top, (geometry.size.height-380)/2)
                .offset(y: isShowing ? 0 : geometry.size.height)
            }.frame(alignment: .center)
        }
        .onChange(of: isShowing) { _ in
            withAnimation(.easeInOut) { self.isFetching = true }
            getAttendenceHistory(api.accessToken, studentId: attendance.id) { result in
                switch result {
                case .success(let attendanceLog):
                    withAnimation(.easeInOut) { self.attendanceLog = attendanceLog}
                case .failure(_):
                    print("Attendance DetailView call history error")
                }
                withAnimation(.easeInOut) { self.isFetching = false }
            }
        }
    }
    
    func dismiss() {
        withAnimation(.spring()) {
            self.isShowing = false
        }
    }
}
