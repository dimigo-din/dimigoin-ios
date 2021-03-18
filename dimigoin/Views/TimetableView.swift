//
//  TimeTableView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/14.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct TimetableView: View {
    @EnvironmentObject var api: DimigoinAPI
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(api.user.grade)학년 \(api.user.klass)반".localized)
                            .notoSans(.bold, size: 13, Color.gray4)
                        Text(NSLocalizedString("시간표", comment: ""))
                            .notoSans(.black, size: 30)
                    }
                    Spacer()
                    Image("calendar.fill").templateImage(height: 35, Color.accent)
                }.horizonPadding()
                .padding(.top, 30)
                VSpacer(29)
                TimetableItem(geometry: geometry)
                    .environmentObject(api)
                VSpacer(100)
            }
        }
    }
    
}

struct TimetableItem: View {
    @EnvironmentObject var api: DimigoinAPI
    @State var geometry: GeometryProxy
    var dayIndicatorXOffset: CGFloat = 0
    
    init(geometry: GeometryProxy) {
        self._geometry = .init(initialValue: geometry)
        self.dayIndicatorXOffset = CGFloat(getTodayDayOfWeekInt()-1)*(geometry.size.width-40)/5
    }
    
    var body: some View {
        VStack {
            VSpacer(10)
            ZStack(alignment: .topLeading) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(1...5, id: \.self) { day in
                        VStack {
                            Text(NSLocalizedString(dayOfWeek[day], comment: "")).notoSans(.medium, size: 18, Color.gray4).frame(width: abs(geometry.size.width-40)/5, height: 20)
                            VSpacer(29)
                            ForEach(api.timetable.lectures[day-1], id: \.self) { lecture in
                                VStack(spacing: 0) {
                                    Text("\(lecture)")
                                        .notoSans(.medium, size: 18, getTodayDayOfWeekInt() == day ? Color.accent : Color.gray4)
                                        .frame(width: abs(geometry.size.width-40)/5, height: 20)
                                        .padding(.top, 15)
                                        .padding(.bottom, 15)

                                }
                            }
                        }
                    }
                }
                HDivider().offset(y: 33)
                HDivider().offset(y: -12)
            }.horizonPadding()
        }
    }
}
