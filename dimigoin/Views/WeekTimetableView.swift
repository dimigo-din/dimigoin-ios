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
        ScrollView {
            VStack(alignment: .leading) {
                VStack {
                    HStack(alignment: .top) {
                        ForEach((1...5), id: \.self) { day in
                            VStack(alignment: .center){
                                Text("\(getDay(day))").highlight().heavy()
                                Divider()
                                ForEach(timetable.data[day-1], id: \.self) { lecture in
                                    Text("\(lecture)").body().padding(.bottom, 5)
                                }
                            }
                        }
                    }
                }.CustomBox()
                
                Divider()
                Text("정보").headline()
            }
            .navigationBarTitle(Text("\(user.grade)학년 \(user.klass)반 시간표"))
        }.padding()
    }
}

struct WeekTimetableView_Previews: PreviewProvider {
    static var previews: some View {
        WeekTimetableView()
    }
}
