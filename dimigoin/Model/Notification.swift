//
//  Notification.swift
//  dimigoin
//
//  Created by 변경민 on 2020/10/20.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager {
    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                if granted == true && error == nil {
                    // 권한 얻음
                }
        }
    }
    
    func scheduleBeneduNotifications() -> Void {
        let content = UNMutableNotificationContent()
        content.title = "오늘의 베네듀, 하셨나요?"
        content.subtitle = "베네듀 일일학습지를 완료해주세요! 😄"
        content.sound = UNNotificationSound.default
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.hour = 8    // 14:00 hours
        dateComponents.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//         choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        // add our notification request
        
        UNUserNotificationCenter.current().add(request)
        print("Notification requested")
    }
    func removeAllNotifications() -> Void {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("All Notifications are removed")
    }
}
