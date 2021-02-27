//
//  AttendanceHistoryView.swift
//  dimigoin
//
//  Created by 변경민 on 2021/02/07.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct AttendanceHistoryView: View {
    @EnvironmentObject var api: DimigoinAPI
    @Binding var isShowing: Bool
    @State var attendanceLog: [AttendanceLog] = []
    @Binding var selectedGrade: Int
    @Binding var selectedClass: Int
    @State var isFetcing: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all).opacity(isShowing ? 0.1 : 0)
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    ZStack {
                        VStack {
                            VSpacer(35)
                            Text("\(selectedGrade)학년 \(selectedClass)반")
                                .notoSans(.bold, size: 10, Color.accent)
                            VSpacer(4)
                            Text("히스토리")
                                .notoSans(.bold, size: 20, Color.text)
                            VSpacer(15)
                            ScrollView {
                                VStack(spacing: 15) {
                                    if isFetcing {
                                        ProgressView()
                                    } else {
                                        ForEach(0..<attendanceLog.count, id: \.self) { idx in
                                            Text("[ \(attendanceLog[idx].time) ] \(attendanceLog[idx].student.name)님이 자신의 현황을 ")
                                                .notoSans(.medium, size: 10, Color.gray4)
                                            +
                                            Text(attendanceLog[idx].place.name)
                                                .notoSans(.bold, size: 10, Color.accent)
                                            +
                                            Text("(으)로 변경")
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
                .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? abs(geometry.size.width - 80) : 295, height: 400)
                .background(Color(UIColor.systemBackground).cornerRadius(10))
                .edgesIgnoringSafeArea(.all)
                .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .phone ? 40 : (geometry.size.width - 295)/2)
                .padding(.top, (geometry.size.height-400)/2)
                .offset(y: isShowing ? 0 : geometry.size.height)
            }.frame(alignment: .center)
        }
        .onChange(of: selectedGrade) { _ in
            fetchAttendanceLog()
        }
        .onChange(of: selectedClass) { _ in
            fetchAttendanceLog()
        }
    }
    
    func fetchAttendanceLog() {
        withAnimation(.easeInOut) { self.isFetcing = true }
        getClassHistory(api.accessToken, grade: selectedGrade, klass: selectedClass) { result in
            switch result {
            case .success(let attendanceLog):
                withAnimation(.easeInOut) { self.attendanceLog = attendanceLog }
            case .failure(_):
                print("get attendanceLog failed in Attendance HistoryView")
            }
            withAnimation(.easeInOut) { self.isFetcing = false }
        }
    }
    
    func dismiss() {
        withAnimation(.spring()) {
            self.isShowing = false
        }
    }
}
