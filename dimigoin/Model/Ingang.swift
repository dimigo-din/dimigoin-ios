//
//  Ingang.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation

struct Ingang: Hashable {
    var idx: Int
    var day: String
    var title: String
    var time: Int
    var request_start_date: Int
    var request_end_date: Int
    var status: Bool
    var present: Int
    var max_user: Int
}

let dummyIngang1 = Ingang(idx: 0, day: "mon", title: "6월 27일 야간자율 학습 1타임", time: 1, request_start_date: 0, request_end_date: 1, status: false, present: 5, max_user: 9)
let dummyIngang2 = Ingang(idx: 0, day: "mon", title: "6월 27일 야간자율 학습 2타임", time: 2, request_start_date: 0, request_end_date: 1, status: true, present: 3, max_user: 9)

struct IngangStatus: Hashable {
    var weekly_request_count: Int
    var daily_request_count: Int
    var weekly_ticket_num: Int
    var daily_ticket_num: Int
}

let ingangTime = [
    "",
    "19:50 ~ 21:10",
    "21:30 ~ 22:30"
]
