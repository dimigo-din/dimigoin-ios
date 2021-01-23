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
    var icon: String
    
    init(_ title: String, sub subTitle: String, icon: String) {
        self.title = title
        self.subTitle = subTitle
        self.icon = icon
    }
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 0){
                Text(NSLocalizedString(self.subTitle, comment: "")).subTitle()
                Text(NSLocalizedString(self.title, comment: "")).title()
            }
            Spacer()
            Image(icon).renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(height: 35).foregroundColor(Color.accent)
        }.horizonPadding()
        .padding(.top, 30)
        HDivider().horizonPadding().offset(y: -15)
        VSpacer(10)
        
        
    }
}


