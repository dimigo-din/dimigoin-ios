//
//  TimetableRow.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/29.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TimetableRow: View {
    @State var timetable: TimeTable
    
    var body: some View {
        VStack {
            HStack {
                Text("시간표").sectionHeader()
                Spacer()
                NavigationLink(destination: WeekTimetableView()) {
                    Text("전체 시간표 보기")
                }
            }
            VSpacer(15)
            VStack {
                TimetableItem(timetable: timetable)
            }.CustomBox()
        }
    }
}

struct TimetableRow_Previews: PreviewProvider {
    static var previews: some View {
        TimetableRow(timetable: dummyTimeTable)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
