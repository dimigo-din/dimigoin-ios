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
    @State var timetableAPI: TimetableAPI = TimetableAPI()
    var grade: Int =  UserDefaults(suiteName: "group.in.dimigo.ios")?.integer(forKey: "user.grade") ?? 2
    var klass: Int = UserDefaults(suiteName: "group.in.dimigo.ios")?.integer(forKey: "user.klass") ?? 4
    var data: WidgetEntry
    
    var body: some View {
        ZStack {
            Image(data.tokenExist == false ? "dangermark" : "logo").resizable().aspectRatio(contentMode: .fit).frame(width: 60)
                .opacity(data.tokenExist == false ? 0.4 : 0.25)
            GeometryReader { geometry in
                Rectangle().fill(Color(data.tokenExist == false ? "red" : "accent")).frame(width: geometry.size.width, height: 4)
            }
            if(data.tokenExist) {
                GeometryReader { geometry in
                    if(isWeekday()) {
                        VStack {
                            Spacer()
                            ZStack(alignment: .topLeading){
                                HStack(alignment: .top, spacing: 0) {
                                    ForEach(1...5, id: \.self) { day in
                                        VStack {
                                            Text(NSLocalizedString(dayOfWeek[day], comment: "")).font(Font.custom("NotoSansKR-Bold", size: 20))
                                                .foregroundColor(Color(getTodayDayOfWeekInt() == day ? "accent" : "gray4"))
                                            VSpacer(20)
                                            ForEach(timetableAPI.getTimetable(grade: grade, klass: klass).data[day-1], id: \.self) { lecture in
                                                Text("\(lecture)")
                                                    .frame(width: (geometry.size.width-40)/5, height: 20)
                                                    .padding(.vertical, 4)
                                                    .font(Font.custom("NotoSansKR-Regular", size: 14))
                                                    .foregroundColor(Color(getTodayDayOfWeekInt() == day ? "accent" : "gray4"))
                                            }
                                        }
                                        .padding(.vertical, 5)
                                        .background(Color("accent").frame(height: geometry.size.height).opacity(getTodayDayOfWeekInt() == day ? 0.06 : 0).cornerRadius(5))
                                    }
                                }
                                Divider().offset(y: 45)
                                Rectangle()
                                    .fill(Color("accent"))
                                    .frame(width: (geometry.size.width-40)/5, height: 3)
                                    .cornerRadius(2)
                                    .offset(x: CGFloat(getTodayDayOfWeekInt()-1)*(geometry.size.width-40)/5, y: 44)
                            }.padding(.horizontal)
                            Spacer()
                        }
                    } else {
                        VStack {
                            Spacer()
                            ZStack(alignment: .topLeading){
                                HStack(alignment: .top, spacing: 0) {
                                    ForEach(1...5, id: \.self) { day in
                                        VStack {
                                            Text("\(dayOfWeek[day])").font(Font.custom("NotoSansKR-Bold", size: 20))
                                                .foregroundColor(Color("gray4"))
                                            VSpacer(20)
                                            ForEach(timetableAPI.getTimetable(grade: grade, klass: klass).data[day-1], id: \.self) { lecture in
                                                Text("\(lecture)")
                                                    .frame(width: (geometry.size.width-40)/5, height: 20)
                                                    .padding(.vertical, 4)
                                                    .font(Font.custom("NotoSansKR-Regular", size: 14))
                                                    .foregroundColor(Color("gray4"))
                                            }
                                        }.padding(.vertical, 5)
                                    }
                                }
                                Divider().offset(y: 45)
                            }.padding(.horizontal)
                            Spacer()
                        }
                    }
                }
            } else {
                Text("사용자 정보가 동기화 되지 않았습니다. 앱을 실행하여 로그인 하거나 이미 로그인을 완료했다면 잠시만 기다려주세요.😉").caption3().padding(.horizontal)
            }
            
        }
    }
}
