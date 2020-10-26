//
//  NotificationView.swift
//  watchApp Extension
//
//  Created by 변경민 on 2020/10/26.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        VStack {
            Text("오늘 아침 급식입니다.").highlight().black()
            Text("닭다리삼계죽 | 보조밥 | 고기산적&케찹 | 호박버섯볶음 | 건새우마늘쫑볶음 | 깍두기 | 모듬과일 | 미니크라상&잼 | 푸딩").padding()
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
