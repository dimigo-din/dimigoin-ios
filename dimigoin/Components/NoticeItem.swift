//
//  NoticeItem.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/26.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct NoticeItem: View {
    @State var notice: Notice

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(notice.registered).highlight().headline()
                Text(notice.type).caption().headline()
            }
            
            VSpacer(10)

            Text(self.notice.description)
                .background(Color.white)
        }.modifier(RoundBoxModifier())
    }
}

struct NoticeItem_Previews: PreviewProvider {
    static var previews: some View {
        NoticeItem(notice: dummyNotice1)
            .previewLayout(.sizeThatFits)
    }
}
