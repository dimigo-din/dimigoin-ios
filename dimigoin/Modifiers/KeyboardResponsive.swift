//
//  KeyboardResponsive.swift
//  dimigoin
//
//  Created by 변경민 on 2021/01/15.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI
import Combine

struct KeyboardResponsiveModifier: ViewModifier {
  @State private var offset: CGFloat = 0

  func body(content: Content) -> some View {
    content
      .padding(.bottom, offset)
      .onAppear {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
            let value = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            let height = value.height
            let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
            withAnimation(Animation.easeOut(duration: 0.25)) {
                self.offset = height/2 - (bottomInset ?? 0)
            }
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notif in
            withAnimation(Animation.easeInOut(duration: 0.25)){
              self.offset = 0
            }
        }
    }
  }
}

extension View {
  func keyboardResponsive() -> ModifiedContent<Self, KeyboardResponsiveModifier> {
    return modifier(KeyboardResponsiveModifier())
  }
}
