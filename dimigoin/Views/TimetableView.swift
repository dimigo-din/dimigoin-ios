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
            ScrollView {
                HStack {
                    ViewTitle("시간표", sub: getDateString())
                    Spacer()
                    Image("calender").resizable().aspectRatio(contentMode: .fit).frame(height: 40)
                    .onTapGesture {
                        self.magicNum -= 1
                        if(magicNum == 0) {
                            revealSecret()
                        }
                    }
                }.horizonPadding()
                .padding(.top, 40)
                HDivider().horizonPadding().offset(y: -15)
                TimetableItem(grade: userAPI.user.grade, klass: userAPI.user.klass, isMagicRevealed: $isMagicRevealed)
                    .environmentObject(timetableAPI)
            }
        }
    }
    var dayIndicatorXOffset: CGFloat = CGFloat(getTodayDayOfWeekInt()-1)*(UIScreen.screenWidth-40)/5
    func pickerButton(type:String, _ value: Int) -> some View{
        return Text("\(value)\(type)")
            .foregroundColor(Color.white)
            .sectionHeader()
            .padding(.horizontal, 10)
            .background(Color("accent"))
            .cornerRadius(5)
        
    }
    
    private func revealSecret() {
        alertManager.createAlert("이스터에그를 발견하셨네요!", sub: "축하드립니다🥳 이제 모든 교실의 시간표를 조회할 수 있습니다.", .success)
        UserDefaults.standard.setValue(true, forKey: "Magic")
        withAnimation() {
            self.isMagicRevealed = true
        }
    }
    
}

struct TimetableItem: View{
    @EnvironmentObject var timetableAPI: TimetableAPI
    @State var grade: Int
    @State var klass: Int
    @Binding var isMagicRevealed: Bool
    var dayIndicatorXOffset: CGFloat = CGFloat(getTodayDayOfWeekInt()-1)*(UIScreen.screenWidth-40)/5
    func pickerButton(type:String, _ value: Int) -> some View{
        return Text("\(value)\(type)")
            .foregroundColor(Color.white)
            .sectionHeader()
            .padding(.horizontal, 7)
            .background(Color("accent"))
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
                }
            }
            VSpacer(10)
            if(isWeekday()) {
                ZStack(alignment: .topLeading){
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(1...5, id: \.self) { day in
                            VStack {
                                Text(NSLocalizedString(dayOfWeek[day], comment: "")).font(Font.custom("NotoSansKR-Bold", size: 20))
                                    .foregroundColor(Color(getTodayDayOfWeekInt() == day ? "accent" : "gray4"))
                                VSpacer(20)
                                ForEach(timetableAPI.getTimetable(grade: grade, klass: klass).data[day-1], id: \.self) { lecture in
                                    Text("\(lecture)")
                                        .frame(width: (UIScreen.screenWidth-40)/5, height: 20)
                                        .padding(.vertical, 4)
                                        .font(Font.custom("NotoSansKR-Regular", size: 14))
                                        .foregroundColor(Color(getTodayDayOfWeekInt() == day ? "accent" : "gray4"))
                                }
                            }
                            .padding(.vertical, 5)
                            .background(Color("accent").opacity(getTodayDayOfWeekInt() == day ? 0.09 : 0).cornerRadius(5))
                        }
                    }
                    Divider().offset(y: 45)
                    Rectangle()
                        .fill(Color("accent"))
                        .frame(width: (UIScreen.screenWidth-40)/5, height: 3)
                        .cornerRadius(2)
                        .offset(x: dayIndicatorXOffset, y: 44)
                }.horizonPadding()
            } else {
                ZStack(alignment: .topLeading){
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(1...5, id: \.self) { day in
                            VStack {
                                Text("\(dayOfWeek[day])").font(Font.custom("NotoSansKR-Bold", size: 20))
                                    .foregroundColor(Color("gray4"))
                                VSpacer(20)
                                ForEach(timetableAPI.getTimetable(grade: grade, klass: klass).data[day-1], id: \.self) { lecture in
                                    Text("\(lecture)")
                                        .frame(width: (UIScreen.screenWidth-40)/5, height: 20)
                                        .padding(.vertical, 4)
                                        .font(Font.custom("NotoSansKR-Regular", size: 14))
                                        .foregroundColor(Color("gray4"))
                                }
                            }.padding(.vertical, 5)
                        }
                    }
                    Divider().offset(y: 45)
                }.horizonPadding()
            }
        }
    }
}
