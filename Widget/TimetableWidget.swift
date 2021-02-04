//
//  TimetableWidget.swift
//  WidgetExtension
//
//  Created by 변경민 on 2021/01/07.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct TimetableWidget: View {
    var data: WidgetEntry
    @State var isLoggedIn = UserDefaults(suiteName: appGroupName)?.bool(forKey: "isLoggedIn") ?? false
    var body: some View {
        ZStack {
            Image(isLoggedIn == false ? "dangermark" : "logo")
                .templateImage(width: 60, isLoggedIn == false ? Color("red") : Color.accent)
                .opacity(isLoggedIn == false ? 0.4 : 0.25)
            GeometryReader { geometry in
                Rectangle().fill(isLoggedIn == false ? Color("red") : Color.accent).frame(width: geometry.size.width, height: 4)
            }
            if isLoggedIn {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        ZStack(alignment: .topLeading) {
                            HStack(alignment: .top, spacing: 0) {
                                ForEach(1...5, id: \.self) { day in
                                    VStack {
                                        Text(NSLocalizedString(dayOfWeek[day], comment: ""))
                                            .notoSans(.medium, size: 18, getTodayDayOfWeekInt() == day ? Color.accent : Color.gray4)
                                        VSpacer(20)
                                        ForEach(loadTimetable(day: day-1), id: \.self) { lecture in
                                            Text("\(lecture)")
                                                .frame(width: (geometry.size.width-40)/5, height: 20)
                                                .padding(.vertical, 4)
                                                .font(Font.custom("NotoSansKR-Regular", size: 14))
                                                .foregroundColor(getTodayDayOfWeekInt() == day ? Color.accent : Color.gray4)
                                        }
                                    }
                                    .padding(.vertical, 5)
                                    .background(Color.accent.frame(height: geometry.size.height).opacity(getTodayDayOfWeekInt() == day ? 0.06 : 0).cornerRadius(5))
                                }
                            }
                            Divider().offset(y: 45)
                        }.padding(.horizontal)
                        Spacer()
                    }
                }
            } else {
                Text("사용자 정보가 동기화 되지 않았습니다. 앱을 실행하여 로그인 하거나 이미 로그인을 완료했다면 잠시만 기다려주세요.😉").notoSans(.regular, size: 11).padding(.horizontal)
            }
        }
    }
}
