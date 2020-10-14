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
        ZStack {
            Image("school").resizable().scaledToFit().offset(y: UIScreen.screenHeight/2 - 80)
            ScrollView {
                TimetableItem(timetable: timetable).padding()
                .navigationBarTitle(Text("\(user.grade)학년 \(user.klass)반 시간표"))
            }
        }
    }
}

struct WeekTimetableView_Previews: PreviewProvider {
    static var previews: some View {
        WeekTimetableView()
    }
}
