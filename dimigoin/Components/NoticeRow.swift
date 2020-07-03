//
//  NoticeRow.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct NoticeRow: View {
    @State var notices: [Notice]
    
    var body: some View {
        VStack {
            HStack {
                Text("공지사항")
                    .font(.headline)
                Spacer()
                NavigationLink(destination: NoticeListView()) {
                    Text("더 보기")
                }
                
            }
            
            VSpacer(15)
            
            VStack(spacing: 15.0) {
                ForEach(0 ..< self.notices.count) { noticeIndex in
                    if noticeIndex < 3 {
                        NoticeItem(notice: self.notices[noticeIndex])
                    }
                }
            }
        }
    }
}

struct NoticeRow_Previews: PreviewProvider {
    static var previews: some View {
        NoticeRow(notices: [dummyNotice1, dummyNotice2])
            .previewLayout(.sizeThatFits)
    }
}
