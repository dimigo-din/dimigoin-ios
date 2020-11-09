//
//  NavigationTitle.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/09.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct ViewTitle: View {
    var title: String
    var subTitle: String
    var img: String
    init(_ title: String, sub subTitle: String, img: String) {
        self.title = title
        self.subTitle = subTitle
        self.img = img
    }
    var body: some View {
        HStack(alignment: .center){
            VStack(alignment: .leading, spacing: 0){
                Text(self.subTitle).subTitle()
                Text(self.title).title()
            }
            Spacer()
            Image(self.img).resizable().aspectRatio(contentMode: .fit).frame(height: 40)
        }.horizonPadding()
        .padding(.top, 40)
    }
}


