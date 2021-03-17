//
//  Alert.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/09.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation
import DimigoinKit
import SwiftUI

public enum Alert {
    public static func present() {
        AlertViewController(alertView: AlertView(icon: .checkmark, color: .accent, message: "hello")).present()
    }
}
