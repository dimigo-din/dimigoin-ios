//
//  Notice.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation

struct Notice: Hashable, Codable {
    var type: String
    var registered: String
    var description: String
}

let dummyNotice1 = Notice(type: "디미고인", registered: "2020년 8월 10일", description: "디미고인 iOS앱이 출시됐습니다! 🎉")
let dummyNotice2 = Notice(type: "학과", registered: "2020년 7월 10일", description: "2차 지필고사 기간은 7월 23일 ~ 7월 28입니다.")
