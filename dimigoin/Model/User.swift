//
//  User.swift
//  dimigoin
//
//  Created by 변경민 on 2020/07/25.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation
import SwiftUI

struct User {
    var name: String
    var id: String
    var idx: Int
    var grade: String
    var klass: String
    var number: String
    var serial: String
    var photo: Image
    var email: String
    var user_type: String
    var weekly_request_count: Int
    var daily_request_count: Int
    var weekly_ticket_num: Int
    var daily_ticket_num: Int
}

func getMajor(klass: Int) -> String {
    switch klass {
        case 1: return "이비즈니스과"
        case 2: return "디지털컨텐츠과"
        case 3: return "웹프로그래밍과"
        case 4: return "웹프로그래밍과"
        case 5: return "해킹방어과"
        case 6: return "해킹방어과"
        default: return "N/A"
    }
}

let dummyUser: User = User(name: "변경민",
                          id: "bkmchangemin",
                          idx: 2121,
                          grade: "2",
                          klass: "4",
                          number: "13",
                          serial: "2413",
                          photo: Image(systemName: "person.crop.circle"),
                          email: "bkm.change.min@gmail.com",
                          user_type: "S",
                          weekly_request_count: 0,
                          daily_request_count: 0,
                          weekly_ticket_num: 5,
                          daily_ticket_num: 2)
