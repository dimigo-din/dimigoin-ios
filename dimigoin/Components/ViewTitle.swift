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
    
    init(_ title: String, sub subTitle: String) {
        self.title = title
        self.subTitle = subTitle
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(self.subTitle).subTitle()
            Text(self.title).title()
        }
    }
}


