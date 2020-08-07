//
//  DateTime.swift
//  dimigoin
//
//  Created by 변경민 on 2020/07/25.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation

func getDay() -> String {
    let now = Date()
    let date = DateFormatter()
    date.locale = Locale(identifier: "ko_kr")
    date.timeZone = TimeZone(abbreviation: "KST")
    date.dateFormat = "E"
    
    return date.string(from: now)
}

func getDay(_ day: Int) -> String {
    var dayString: String = "error"
    switch day {
        case 1: dayString = "월"
        case 2: dayString =  "화"
        case 3: dayString =  "수"
        case 4: dayString =  "목"
        case 5: dayString =  "금"
        case 6: dayString =  "토"
        case 7: dayString =  "일"
        default: return "error"
    }
    return dayString
}

func getDate() -> String {
    let now = Date()
    let date = DateFormatter()
    date.locale = Locale(identifier: "ko_kr")
    date.timeZone = TimeZone(abbreviation: "KST")
    date.dateFormat = "M월 d일"

    return "\(date.string(from: now)) \(getDay())요일"
}

func getAPIDate() -> String {
    var now = Date()
    let hour = Calendar.current.component(.hour, from: now)
    if(Int(hour) >= 22) { // after 10pm, show tomorrow meals
        now = tomorrow()
    }
    let date = DateFormatter()
    date.locale = Locale(identifier: "ko_kr")
    date.timeZone = TimeZone(abbreviation: "KST")
    date.dateFormat = "yyyyMMdd"
    return date.string(from: now)
}

func tomorrow() -> Date {
    
    var dateComponents = DateComponents()
    dateComponents.setValue(1, for: .day); // +1 day
    
    let now = Date() // Current date
    let tomorrow = Calendar.current.date(byAdding: dateComponents, to: now)  // Add the DateComponents
    
    return tomorrow!
}

func isWeekday() -> Bool {
    let today = getDay()
    if(today == "토" || today == "일") {
        return false
    }
    else {
       return true
    }
}
