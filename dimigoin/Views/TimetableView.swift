//
//  WeekTimetableView.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/29.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TimetableView: View {
    @State var timeTableAPI = TimeTableAPI()
    @ObservedObject var userAPI: UserAPI
    var body: some View {
        VStack {
            Picker(selection: $userAPI.user.grade, label: Text("학년을 선택하세요")) {
                Text("1학년").tag(1)
                Text("2학년").tag(2)
                Text("3학년").tag(3)
            }.pickerStyle(SegmentedPickerStyle())
            .padding(.leading).padding(.trailing)
            Picker(selection: $userAPI.user.klass, label: Text("반을 선택하세요")) {
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
                            ForEach(timeTableAPI.getTimeTable(grade: userAPI.user.grade, klass: userAPI.user.klass).data[day-1], id: \.self) { lecture in
                                Text("\(lecture)").body().padding(.bottom, 5)
                            }
                        }
                    }
                }
            }.CustomBox()
            .padding()
            .navigationBarTitle(Text("\(userAPI.user.grade)학년 \(userAPI.user.klass)반 시간표"))
        }.onDisappear(perform: {
            userAPI.getUserData()
        })
        Spacer()
    }
}

//struct WeekTimetableView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimetableView()
//    }
//}
