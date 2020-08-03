//
//  Notice.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation
import Alamofire

struct Notice: Hashable, Codable, Identifiable {
    var id = UUID()
    var type: String
    var registered: String
    var description: String
}

class NoticeAPI: ObservableObject {
    @Published var notice = Notice(type: "", registered: "", description: "")
    func getNotice() {
        let headers: HTTPHeaders = [
            "Authorization":"Bearer token"
        ]
        let url = "https://api.dimigo.in/notice/lastest"
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).response { response in
            if let status = response.response?.statusCode {
//                switch(status) {
//                case 200:
//                    guard let data = response.data else { return }
//                    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                    self.tokens.token = json["token"] as! String
//                    
//                default:
//                    self.tokenStatus = .fail
//                }
            }
        }
    }
}

let dummyNotice1 = Notice(type: "디미고인", registered: "2020년 8월 10일", description: "디미고인 iOS앱이 출시됐습니다! 🎉")
let dummyNotice2 = Notice(type: "학과", registered: "2020년 7월 10일", description: "2차 지필고사 기간은 7월 23일 ~ 7월 28입니다.")
