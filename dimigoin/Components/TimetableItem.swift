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

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                ForEach(0 ..< subjectsCount) { index in
                    if index == self.currentTime {
                        Text(self.subjects[index]).highlight().headline()
                    } else {
                        Text(self.subjects[index])
                    }
                    if index < self.subjectsCount - 1 {
                        Spacer()
                    }
                }
            }
        }.CustomBox()
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
