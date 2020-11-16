//
//  HorizonPadding.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/14.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

extension View {
    func horizonPadding() -> some View {
        return self.padding(.leading, 20).padding(.trailing, 20)
    }
    func verticalPadding() -> some View {
        self.padding(.top, 20).padding(.bottom, 20)
    }
}
