//
//  CopyrightText.swift
//  dimigoin
//
//  Created by 변경민 on 2020/08/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct CopyrightText: View {
    var body: some View {
        VStack {
            Text("© 2020 ").caption2()
            +
            Text("DIMIGOIN").caption2().bold()
            +
            Text(" Communications").caption2()
        }.padding(.bottom)
    }
}
