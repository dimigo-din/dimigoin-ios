//
//  dimigoinApp.swift
//  watchApp Extension
//
//  Created by 변경민 on 2020/10/26.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

@main
struct dimigoinApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
