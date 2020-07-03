//
//  TimetableRow.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/29.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TimetableRow: View {
    @State var subjects: [String]
    
    var body: some View {
        VStack {
            HStack {
                Text("시간표")
                    .font(.headline)
                Spacer()
                NavigationLink(destination: WeekTimetableView()) {
                    Text("전체 시간표 보기")
                }
            }
            
            VSpacer(15)

            TimetableItem(subjects: subjects)
        }
    }
}

struct TimetableRow_Previews: PreviewProvider {
    static var previews: some View {
        TimetableRow(subjects: dummySubjects)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
