//
//  WeekTimetableView.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/29.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct WeekTimetableView: View {
    @State var timetable = dummyTimeTable
    @State var user = dummyUser
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .top) {
                ForEach((1...5), id: \.self) { day in
                    VStack(alignment: .center){
                        Text("\(getDay(day))").highlight().heavy()
                        Divider().frame(height: 2)
                        ForEach(timetable.data[day-1], id: \.self) { lecture in
                            Text("\(lecture)").body().padding(.bottom, 5)
                        }
                    }
                }
            }
        }.CustomBox()
        .padding()
        .navigationBarTitle(Text("\(user.grade)학년 \(user.klass)반 시간표"))
        Spacer()
    }
}

struct WeekTimetableView_Previews: PreviewProvider {
    static var previews: some View {
        WeekTimetableView()
    }
}
