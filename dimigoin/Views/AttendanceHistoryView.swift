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
    @Binding var isShowing: Bool
    @EnvironmentObject var api: DimigoinAPI
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all).opacity(isShowing ? 0.1 : 0)
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    ZStack {
                        VStack {
                            VSpacer(35)
                            Text("\(api.user.grade)학년 \(api.user.klass)반")
                                .notoSans(.bold, size: 10, Color.accent)
                            VSpacer(4)
                            Text("히스토리")
                                .notoSans(.bold, size: 20, Color.text)
                            VSpacer(15)
                            ScrollView {
                                VStack(spacing: 15) {
//                                    ForEach(0..<attendance.attendanceLog.count, id: \.self) { idx in
//                                        Text("[ \(attendance.isEnrolled ? attendance.timeline[idx] : "디미고인") ] \(attendance.name)님이 자신의 현황을 ")
//                                            .notoSans(.medium, size: 10, Color.gray4)
//                                        +
//                                        Text(attendance.attendanceLog[idx].name)
//                                            .notoSans(.bold, size: 10, Color.accent)
//                                        +
//                                        Text("(으)로 \(attendance.isEnrolled ? "변경" : "등록")")
//                                            .notoSans(.medium, size: 10, Color.gray4)
//                                    }
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
    }
    
    func dismiss() {
        withAnimation(.spring()) {
            self.isShowing = false
        }
    }
}
