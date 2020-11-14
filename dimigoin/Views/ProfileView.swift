//
//  AssignView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var userAPI: UserAPI
    var body: some View {
        ScrollView {
            HStack {
                ViewTitle("내정보", sub: "")
                Spacer()
            }.horizonPadding()
            .padding(.top, 40)
            HDivider().horizonPadding().offset(y: -15)
        }
    }
}
