//
//  AttendanceDetailView.swift
//  dimigoin
//
//  Created by 변경민 on 2021/02/02.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct AttendanceDetailView: View {
    @State var attendance: Attendance
    
    init(attendance: Attendance) {
        self._attendance = .init(initialValue: attendance)
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        ScrollView {
            Text("\(attendance.name)")
        }
    }
}
