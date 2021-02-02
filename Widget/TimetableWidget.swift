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
    var api: DimigoinAPI
    var data: WidgetEntry
    
    var body: some View {
        ZStack {
            Image(api.isLoggedIn == false ? "dangermark" : "logo").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(width: 60)
                .opacity(api.isLoggedIn == false ? 0.4 : 0.25).foregroundColor(api.isLoggedIn == false ? Color("red") : Color.accent)
            GeometryReader { geometry in
                Rectangle().fill(api.isLoggedIn == false ? Color("red") : Color.accent).frame(width: geometry.size.width, height: 4)
            }
            if api.isLoggedIn {
                Text("\(api.user.grade) \(api.user.klass)")
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        ZStack(alignment: .topLeading) {
                            HStack(alignment: .top, spacing: 0) {
                                ForEach(1...5, id: \.self) { day in
                                    VStack {
                                        Text(NSLocalizedString(dayOfWeek[day], comment: ""))
                                            .notoSans(.bold, size: 20, getTodayDayOfWeekInt() == day ? Color.accent : Color.gray4)
                                        VSpacer(20)
//                                        ForEach(timetableAPI.getTimetable(grade: grade, klass: klass).data[day-1], id: \.self) { lecture in
//                                            Text("\(lecture)")
//                                                .frame(width: (geometry.size.width-40)/5, height: 20)
//                                                .padding(.vertical, 4)
//                                                .font(Font.custom("NotoSansKR-Regular", size: 14))
//                                                .foregroundColor(getTodayDayOfWeekInt() == day ? Color.accent : Color.gray4)
//                                        }
                                    }
                                    .padding(.vertical, 5)
                                    .background(Color.accent.frame(height: geometry.size.height).opacity(getTodayDayOfWeekInt() == day ? 0.06 : 0).cornerRadius(5))
                                }
                            }
                            Divider().offset(y: 45)
                            Rectangle()
                                .fill(Color.accent)
                                .frame(width: (geometry.size.width-40)/5, height: 3)
                                .cornerRadius(2)
                                .offset(x: CGFloat(getTodayDayOfWeekInt()-1)*(geometry.size.width-40)/5, y: 44)
                        }.padding(.horizontal)
                        Spacer()
                    }
                }
            } else {
                Text("\(api.user.grade) \(api.user.klass)")
                Text("사용자 정보가 동기화 되지 않았습니다. 앱을 실행하여 로그인 하거나 이미 로그인을 완료했다면 잠시만 기다려주세요.😉").notoSans(.regular, size: 11).padding(.horizontal)
            }
            
        }
    }
}
