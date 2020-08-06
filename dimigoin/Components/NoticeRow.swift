//
//  NoticeRow.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct NoticeRow: View {
    @ObservedObject var noticeData: NoticeAPI
    
    var body: some View {
        VStack {
            HStack {
                HStack(alignment:.top) {
                    Text("공지사항").sectionHeader()
                    Circle()
                        .foregroundColor(Color("Secondary"))
                        .frame(width: 8, height: 8)
                        .offset(x: -5)
                }
                Spacer()
                NavigationLink(destination: NoticeListView(noticeData: noticeData)) {
                    Text("더 보기").caption1()
                }
            }
            VSpacer(14)
            NoticeItem(noticeData: noticeData)
        }
    }
}
//
//struct NoticeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        NoticeRow(notices: [dummyNotice1, dummyNotice2])
//            .previewLayout(.sizeThatFits)
//    }
//}
