//
//  TimetableItem.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/29.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TimetableItem: View {
    @State var timetable: TimeTable
    @State var user = dummyUser
    
    var body: some View {
        VStack(alignment: .center) {
//                Text("\(user.grade)학년 \(user.klass)반 시간표").highlight().heavy().padding()
            HStack(alignment: .top) {
                ForEach((1...5), id: \.self) { day in
                    if(getDay() == getDay(day) || !isWeekday()) {
                        VStack(alignment: .center){
                            Text("\(getDay(day))").highlight().heavy()
                            Divider().frame(height: 3).background(Color("Primary"))
                            ForEach(timetable.data[day-1], id: \.self) { lecture in
                                Text("\(lecture)").body().padding(.bottom, 5)
                            }
                        }
                    }
                    else {
                        VStack(alignment: .center){
                            Text("\(getDay(day))").disabled().heavy()
                            Divider()
                            ForEach(timetable.data[day-1], id: \.self) { lecture in
                                Text("\(lecture)").disabled().body().padding(.bottom, 5)
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

struct TimetableItem_Previews: PreviewProvider {
    static var previews: some View {
        TimetableItem(timetable: dummyTimeTable)
            .padding()
            .frame(width: 450)
            .previewLayout(.sizeThatFits)
    }
}
