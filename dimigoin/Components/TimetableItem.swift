//
//  TimetableItem.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/29.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TimetableItem: View {
    @ObservedObject var timetableAPI = TimetableAPI()
    @ObservedObject var userAPI: UserAPI
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .top) {
                ForEach((1...5), id: \.self) { day in
                    if(getDay() == getDay(day) || !isWeekday()) {
                        VStack(alignment: .center){
                            Text("\(getDay(day))").accent().heavy()
                            Divider().frame(height: 3).background(Color("accent"))
                            ForEach(timetableAPI.getTimetable(grade: userAPI.user.grade, klass: userAPI.user.klass).data[day-1], id: \.self) { lecture in
                                Text("\(lecture)").body().padding(.bottom, 5)
                            }
                        }
                    }
                    else {
                        VStack(alignment: .center){
                            Text("\(getDay(day))").disabled().heavy()
                            Divider()
                            ForEach(timetableAPI.getTimetable(grade: userAPI.user.grade, klass: userAPI.user.klass).data[day-1], id: \.self) { lecture in
                                Text("\(lecture)").disabled().body().padding(.bottom, 5)
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

