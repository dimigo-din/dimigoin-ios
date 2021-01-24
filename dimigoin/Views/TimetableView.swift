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
    @EnvironmentObject var timetableAPI: TimetableAPI
    @EnvironmentObject var userAPI: UserAPI
    @EnvironmentObject var alertManager: AlertManager
    @State private var magicNum: Int = 5
    @State var isMagicRevealed: Bool = UserDefaults.standard.bool(forKey: "Magic") == true ? true : false
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                HStack {
                    VStack(alignment: .leading, spacing: 0){
                        Text(NSLocalizedString(userAPI.getUserStringClass(), comment: "")).subTitle()
                        Text(NSLocalizedString("시간표", comment: "")).title()
                    }
                    Spacer()
                    Image("calendar.fill").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(height: 35).foregroundColor(Color.accent).onTapGesture {
                        if magicNum == 0 {
                            revealSecret()
                        } else {
                            magicNum -= 1
                        }
                    }
                }.horizonPadding()
                .padding(.top, 30)
                VSpacer(29)
                TimetableItem(grade: userAPI.user.grade, klass: userAPI.user.klass, isMagicRevealed: $isMagicRevealed, geometry: geometry)
                    .environmentObject(timetableAPI)
                VSpacer(100)
            }
        }
    }
    
    private func revealSecret() {
        if(!isMagicRevealed) {
            alertManager.createAlert("이스터에그를 발견하셨네요!", sub: "축하드립니다🥳\n이제 모든 교실의 시간표를 조회할 수 있습니다.", .success)
            UserDefaults.standard.setValue(true, forKey: "Magic")
            withAnimation() {
                self.isMagicRevealed = true
            }
        }
    }
}

struct TimetableItem: View{
    @EnvironmentObject var timetableAPI: TimetableAPI
    @State var grade: Int
    @State var klass: Int
    @Binding var isMagicRevealed: Bool
    @State var geometry: GeometryProxy
    var dayIndicatorXOffset: CGFloat = 0
    init(grade: Int, klass: Int, isMagicRevealed: Binding<Bool>, geometry: GeometryProxy) {
        self._grade = .init(initialValue: grade)
        self._klass = .init(initialValue: klass)
        self._isMagicRevealed = isMagicRevealed
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
            if(isMagicRevealed) {
                if #available(iOS 14.0, *) {
                    HStack {
                        Picker(selection: $grade, label: pickerButton(type:"학년", grade)) {
                            Text("1학년").tag(1)
                            Text("2학년").tag(2)
                            Text("3학년").tag(3)
                        }.pickerStyle(MenuPickerStyle())
                        Picker(selection: $klass, label: pickerButton(type:"반", klass)) {
                            Text("1반").tag(1)
                            Text("2반").tag(2)
                            Text("3반").tag(3)
                            Text("4반").tag(4)
                            Text("5반").tag(5)
                            Text("6반").tag(6)
                        }.pickerStyle(MenuPickerStyle())

                        Spacer()
                    }.horizonPadding()
                    .offset(y: -20)
                }
            }
            VSpacer(10)
            ZStack(alignment: .topLeading){
                HStack(alignment: .top, spacing: 0) {
                    ForEach(1...5, id: \.self) { day in
                        VStack {
                            Text(NSLocalizedString(dayOfWeek[day], comment: "")).font(Font.custom("NotoSansKR-Medium", size: 18))
                                .foregroundColor(Color.gray4)
                            VSpacer(29)
                            ForEach(timetableAPI.getTimetable(grade: grade, klass: klass).data[day-1], id: \.self) { lecture in
                                VStack(spacing: 0) {
                                    Text("\(lecture)")
                                        .frame(width: (geometry.size.width-40)/5, height: 20)
                                        .padding(.top, 9)
                                        .font(Font.custom("NotoSansKR-Medium", size: 18))
                                        .foregroundColor(getTodayDayOfWeekInt() == day ? Color.accent : Color.gray4)
                                    Text("교사명")
                                        .frame(width: (geometry.size.width-40)/5, height: 20)
                                        .padding(.bottom, 9)
                                        .font(Font.custom("NotoSansKR-Medium", size: 10))
                                        .foregroundColor(getTodayDayOfWeekInt() == day ? Color.accent : Color.gray4)
                                }
                                
                            }
                        }
                    }
                }
                HDivider().offset(y: 40)
                HDivider().offset(y: -13)
            }.horizonPadding()
        }
    }
}
