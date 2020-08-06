//
//  Notice.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Notice: Hashable, Codable, Identifiable {
    var id = UUID()
    var type: String
    var registered: String
    var description: String
}

class NoticeAPI: ObservableObject {
    @Published var notice = Notice(type: "", registered: "", description: "")
    var tokenAPI: TokenAPI = TokenAPI()
    init() {
        tokenAPI.loadTokens()
        getNotice()
    }
    func getNotice() {
        print("get notice")
        let headers: HTTPHeaders = [
            "Authorization":"Bearer \(tokenAPI.tokens.token)"
        ]
        let url = "https://api.dimigo.in/notice/latest"
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).response { response in
            if let status = response.response?.statusCode {
                switch(status) {
                case 200:
                    let json = JSON(response.value!)
                    self.notice.description = json["notice"][0]["description"].string!
                    /// temp data until api update
                    self.notice.type = "학과"
                    self.notice.registered = "2020년 7월 10일"
                    ///
                    self.debugNotice()
                default:
                    debugPrint(response)
                    self.tokenAPI.refreshTokens()
                    self.getNotice()
                }
            }
        }
    }
    func debugNotice() {
        print(notice.description)
    }
}

let dummyNotice1 = Notice(type: "디미고인", registered: "2020년 8월 10일", description: "디미고인 iOS앱이 출시됐습니다! 🎉")
let dummyNotice2 = Notice(type: "학과", registered: "2020년 7월 10일", description: "2차 지필고사 기간은 7월 23일 ~ 7월 28입니다.")
