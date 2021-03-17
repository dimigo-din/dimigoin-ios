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
    public static func present(_ message: String, icon: AlertView.AlertIcon, color: Color) {
        AlertViewController(alertView: AlertView(icon: icon, color: color, message: message)).present()
    }
    
    public static func present(_ title: String, remark: String, icon: AlertView.AlertIcon, color: Color) {
        AlertViewController(alertView: AlertView(content: {
            AnyView(
                VStack {
                    VSpacer(40)
                    Image(icon.rawValue).templateImage(width: 30, color)
                    VSpacer(15)
                    Text(title).notoSans(.bold, size: 15, .gray4)
                    Text(remark).notoSans(.medium, size: 13, .gray4).padding(.bottom, 25)
                }
            )
        },
        centerButton: AlertView.Button.center("확인", color: color)
        )).present()
    }
    
    public static func updateRequired() {
        AlertViewController(alertView: AlertView(content: {
            AnyView(
                VStack {
                    VSpacer(40)
                    Image("warningmark").templateImage(width: 30, .yellow)
                    VSpacer(15)
                    Text("최신버전으로 업데이트 해주세요!").notoSans(.bold, size: 15, .gray4)
                    Text("확인을 누르면 앱스토어로 이동합니다").notoSans(.medium, size: 13, .gray4).padding(.bottom, 25)
                }
            )
        },
        leadingButton: AlertView.Button.dismiss(),
        trailingButton: AlertView.Button(label: "확인", color: .yellow, position: .trailing, action: {
            if let url = URL(string: "https://apps.apple.com/app/디미고인/id1548069749") {
                UIApplication.shared.open(url, options: [:])
            }
        })
        )).present()
    }
    
    public static func forgetPassword() {
        AlertViewController(alertView: AlertView(content: {
            AnyView(
                VStack {
                    VSpacer(35)
                    Text("아이디 또는 패스워드를 잊으셨나요?")
                        .notoSans(.bold, size: 14)
                    VSpacer(18)
                    Text("계정을 분실하셨다면 본관 1층 교무실\nIT 특성화부 하미영 선생님께 문의 하시기 바랍니다")
                        .notoSans(.medium, size: 12, .gray4)
                    VSpacer(26)
                }.multilineTextAlignment(.center)
            )
        },
        centerButton: AlertView.Button.center("확인", color: .accent)
        )).present()
    }
    
    public static func readmeBeforeUseIDCard() {
        AlertViewController(alertView: AlertView(content: {
            AnyView(
                VStack {
                    VSpacer(30)
                    HStack {
                        Image("infomark").templateImage(width: 14, height: 14, Color.gray4)
                        Text("사용 전 다음 내용을 반드시 읽어주세요").notoSans(.bold, size: 12, Color.gray4)
                    }
                    VSpacer(24)
                    Text("1. 본 증은 학교가 정식 발급한 학생증입니다.\n이외 신분증 등 활용은 활용처의 규정에 따라 달라질 수 있습니다.\n\n2. 본 증은 본인 이외 타인이 소지 또는 활용할 수 없습니다.\n타인에게 양도하여 입은 피해는 본인의 책임입니다.\n\n3. 스크린샷 또는 사본으로 동일한 효력을 발생시킬 수 없습니다.")
                        .notoSans(.medium, size: 11, Color("gray6"))
                        .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                    VSpacer(23)
                }
            )
        },
        centerButton: AlertView.Button.center("닫기", color: .gray4)
        )).present()
    }
    
    public static func logoutCheck(api: DimigoinAPI) {
        AlertViewController(alertView: AlertView(content: {
            AnyView(
                VStack {
                    VSpacer(48)
                    Image("logout").templateImage(width: 20, Color.accent)
                    VSpacer(20)
                    Text("정말 로그아웃 하시겠습니까?").notoSans(.bold, size: 15, Color.text).padding(.bottom, 40)
                }
            )
        },
        leadingButton: AlertView.Button.dismiss(),
        trailingButton: AlertView.Button(label: "확인", color: Color.accent, position: .trailing, action: {
            api.logout()
        }))).present()
    }
}
