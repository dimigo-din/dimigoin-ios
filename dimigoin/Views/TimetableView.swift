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
    @EnvironmentObject var alertManager: AlertManager
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                HStack {
                    VStack(alignment: .leading, spacing: 0){
//                        Text(NSLocalizedString(api.getUserStringClass(), comment: "")).subTitle()
                        Text(NSLocalizedString("시간표", comment: "")).title()
                    }
                    Spacer()
                    Image("calendar.fill").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(height: 35).foregroundColor(Color.accent)
                }.horizonPadding()
                .padding(.top, 30)
                VSpacer(29)
                TimetableItem(grade: api.user.grade, klass: api.user.klass, geometry: geometry)
                    .environmentObject(api)
                VSpacer(100)
            }
        }
    }
    
}

struct TimetableItem: View{
    @EnvironmentObject var timetableAPI: TimetableAPI
    @State var grade: Int
    @State var klass: Int
    @State var geometry: GeometryProxy
    var dayIndicatorXOffset: CGFloat = 0
    init(grade: Int, klass: Int, geometry: GeometryProxy) {
        self._grade = .init(initialValue: grade)
        self._klass = .init(initialValue: klass)
        self._geometry = .init(initialValue: geometry)
        self.dayIndicatorXOffset = CGFloat(getTodayDayOfWeekInt()-1)*(geometry.size.width-40)/5
    }
    func pickerButton(type:String, _ value: Int) -> some View{
        return Text("\(value)\(type)")
            .foregroundColor(Color.white)
            .sectionHeader()
            .padding(.horizontal, 7)
            .background(Color.accent)
            .cornerRadius(3)
        
    }
    var body: some View {
        VStack {
            VSpacer(10)
            ZStack(alignment: .topLeading){
                HStack(alignment: .top, spacing: 0) {
                    ForEach(1...5, id: \.self) { day in
                        VStack {
                            Text(NSLocalizedString(dayOfWeek[day], comment: "")).font(Font.custom("NotoSansKR-Medium", size: 18))
                                .foregroundColor(Color.gray4)
                            VSpacer(29)
//                            ForEach(timetableAPI.getTimetable(grade: grade, klass: klass).data[day-1], id: \.self) { lecture in
//                                VStack(spacing: 0) {
//                                    Text("\(lecture)")
//                                        .frame(width: (geometry.size.width-40)/5, height: 20)
//                                        .padding(.top, 15)
//                                        .padding(.bottom, 15)
//                                        .font(Font.custom("NotoSansKR-Medium", size: 18))
//                                        .foregroundColor(getTodayDayOfWeekInt() == day ? Color.accent : Color.gray4)
//                                }
//                            }
                        }
                    }
                }
                HDivider().offset(y: 40)
                HDivider().offset(y: -13)
            }.horizonPadding()
        }
    }
}
