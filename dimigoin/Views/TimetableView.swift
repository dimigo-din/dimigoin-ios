//
//  TimeTableView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/14.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TimetableView: View {
    @ObservedObject var timetableAPI: TimetableAPI
    @ObservedObject var userAPI: UserAPI
    var body: some View {
        ScrollView {
            HStack {
                ViewTitle("시간표", sub: getDate())
                Spacer()
                Button(action: {
                    
                }) {
                    Image("calender").resizable().aspectRatio(contentMode: .fit).frame(height: 40)
                }
            }.horizonPadding()
            .padding(.top, 40)
            HDivider().horizonPadding().offset(y: -15)
        }
    }
}
