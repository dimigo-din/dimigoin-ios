//
//  WeekTimetableView.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/29.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TimetableView: View {
    @State var timetable = dummyTimeTable
    @ObservedObject var userAPI: UserAPI
    @State var timeTableAPI = TimeTableAPI()
    @State var user = dummyUser
    @State var grade = 2
    @State var klass = 4
    var body: some View {
        VStack {
            Picker(selection: $grade, label: Text("학년을 선택하세요")) {
                Text("1학년").tag(1)
                Text("2학년").tag(2)
                Text("3학년").tag(3)
            }.pickerStyle(SegmentedPickerStyle())
            .padding(.leading).padding(.trailing)
            Picker(selection: $klass, label: Text("반을 선택하세요")) {
                Text("1반").tag(1)
                Text("2반").tag(2)
                Text("3반").tag(3)
                Text("4반").tag(4)
                Text("5반").tag(5)
                Text("6반").tag(6)
            }.pickerStyle(SegmentedPickerStyle())
            .padding(.leading).padding(.trailing)
            VStack(alignment: .center) {
                HStack(alignment: .top) {
                    ForEach((1...5), id: \.self) { day in
                        VStack(alignment: .center){
                            Text("\(getDay(day))").highlight().heavy()
                            Divider().frame(height: 2)
                            ForEach(timeTableAPI.getTimeTable(grade: grade, klass: klass).data[day-1], id: \.self) { lecture in
                                Text("\(lecture)").body().padding(.bottom, 5)
                            }
                        }
                    }
                }
            }.CustomBox()
            .padding()
            .navigationBarTitle(Text("\(grade)학년 \(klass)반 시간표"))
        }
        Spacer()
    }
}

//struct WeekTimetableView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimetableView()
//    }
//}
