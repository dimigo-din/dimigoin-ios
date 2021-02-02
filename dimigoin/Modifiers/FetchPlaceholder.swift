//
//  FetchPlaceholder.swift
//  dimigoin
//
//  Created by 변경민 on 2021/02/02.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI

struct FetchPlaceholderViewModifier: ViewModifier {
    @Binding var isFetching: Bool

    func body(content: Content) -> some View {
        ZStack {
            if isFetching {
                if #available(iOS 14.0, *) {
                    content.redacted(reason: .placeholder)
                }
            } else {
                content
            }
        }
    }
}

extension View {
    func placeholderWhileFetching(isFetching: Binding<Bool>) -> ModifiedContent<Self, FetchPlaceholderViewModifier> {
        return modifier(FetchPlaceholderViewModifier(isFetching: isFetching))
    }
}
