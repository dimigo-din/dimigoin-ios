//
//  TimetableItem.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/29.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TimetableItem: View {
    @State var subjects: [String]
    @State var timetable = dummyTimeTable
    @State var user = dummyUser
    
    var body: some View {
        VStack(alignment: .center) {
            VStack() {
                Text("\(user.grade)학년 \(user.klass)반 시간표").highlight().heavy().padding()
                HStack {
                    ForEach((1...5), id: \.self) { day in
                        Text("\(getDay(day))")
                    }
                }
                Divider()
                HStack(alignment: .top) {
                    ForEach(timetable.data, id: \.self) { data in
                        VStack {
                            ForEach(data, id: \.self) { lecture in
                                Text("\(lecture)").caption1().padding(.bottom, 5)
                            }
                        }
                    }
                }.multilineTextAlignment(.center)
            }
        }.CustomBox()
    }
    var subjectsCount: Int {
        return subjects.count
    }
    
    var day: String {
        let now = Date()
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.timeZone = TimeZone(abbreviation: "KST")
        date.dateFormat = "E"
        
        return date.string(from: now)
    }
    
    var currentTime: Int {
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        let time = hour * 100 + minute
        
        if time < 950 { return 0 }
        if time < 1050 { return 1 }
        if time < 1150 { return 2 }
        if time < 1250 { return 3 }
        if time < 1440 { return 4 }
        if time < 1540 { return 5 }
        if time < 1640 { return 6 }
        return 7
    }

}

struct TimetableItem_Previews: PreviewProvider {
    static var previews: some View {
        TimetableItem(subjects: dummySubjects)
            .padding()
            .frame(width: 450)
            .previewLayout(.sizeThatFits)
    }
}
