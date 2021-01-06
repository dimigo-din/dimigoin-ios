//
//  FullNoticeListView.swift
//  dimigoin
//
//  Created by 변경민 on 2021/01/07.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct FullNoticeListView: View {
    @EnvironmentObject var noticeAPI: NoticeAPI
    @EnvironmentObject var userAPI: UserAPI
    init() {
        _ = UINavigationBarAppearance()
        if #available(iOS 14.0, *) {
            UINavigationBar.appearance().tintColor = UIColor(Color("accent"))
        }
    }
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Text("hl")
                
            }
        }
        .navigationBarTitle("공지사항")
    }
}
