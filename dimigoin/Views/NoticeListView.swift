//
//  NoticeListView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct NoticeListView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 15.0) {
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("공지사항").font(.headline)
                    ForEach([dummyNotice1, dummyNotice2], id: \.self) { notice in
                        NoticeItem(notice: notice)
                    }
                }
                Divider()
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("정보").font(.headline)
                    Text("학과 관련 공지사항은 교과 선생님들께서 관리하시고, 디미고인 관련 공지사항은 디미고인 팀에서 관리합니다.")
                        .modifier(HelperTextModifier())
                }
                Spacer()
            }.padding()
        }
        .navigationBarTitle("전체 공지사항")
    }
}

struct NoticeListView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeListView()
    }
}
