//
//  Timetable.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/29.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation

struct TimeTable {
    var data: [[String]]
}

let dummySubjects = ["문학", "정보보호", "정통", "진로", "물리", "운동", "공수"]

let dummyTimeTable = TimeTable(data: [["영어", "응개", "문학", "물리학1", "중국어", "성직", "공수"],
                               ["자료구조", "공수", "물리학", "체육", "중국어"],
                               ["공수", "수학1", "응프화", "응개", "정통", "성직"],
                               ["응프화", "정통", "영어1", "물리학1", "수학1", "응개"],
                               ["응개", "수학1", "문학", "자료구조", "물리학1", "체육", "진로"]])
