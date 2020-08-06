//
//  Ingang.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Ingang: Hashable, Codable {
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

class IngangAPI: ObservableObject {
    @Published var ingangs: [Ingang] = []
    var tokenAPI = TokenAPI()
    init() {
        self.tokenAPI.loadTokens()
        self.getIngangList()
    }
    
    func getIngangList() {
        print("get ingang list")
        let headers: HTTPHeaders = [
            "Authorization":"Bearer \(tokenAPI.tokens.token)"
        ]
        let url = "https://api.dimigo.in/ingang/"
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).response { response in
            if let status = response.response?.statusCode {
                switch(status) {
                case 200:
                    let json = JSON(response.value!)
                    let ingangCnt = json["ingangs"].count
                    print("\(ingangCnt)개의 인강이 있습니다")
                    for idx in 0..<ingangCnt {
                        let newIngang = Ingang(idx: json["ingangs"][idx]["idx"].int!,
                                               day: json["ingangs"][idx]["day"].string!,
                                               title: json["ingangs"][idx]["title"].string!,
                                               time: json["ingangs"][idx]["time"].int!,
                                               request_start_date: json["ingangs"][idx]["idx"].int!,
                                               request_end_date: json["ingangs"][idx]["request_end_date"].int!,
                                               status: json["ingangs"][idx]["status"].bool!,
                                               present: json["ingangs"][idx]["present"].int!,
                                               max_user: json["ingangs"][idx]["max_user"].int!)
                        self.ingangs.append(newIngang)
                    }
                    self.debugIngangs()
                default:
                    debugPrint(response)
                    self.tokenAPI.refreshTokens()
                    self.getIngangList()
                }
            }
        }
    }
    func debugIngangs() {
        for ingang in self.ingangs {
            print(ingang)
        }
    }
    func getTickets() {
        let headers: HTTPHeaders = [
            "Authorization":"Bearer \(tokenAPI.tokens.token)"
        ]
        let url = "https://api.dimigo.in/ingang/"
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).response { response in
            if let status = response.response?.statusCode {
                switch(status) {
                case 200:
                    let json = JSON(response.value!)
                    let weekly_request_count = json["weekly_request_count"].int!
                    let daily_request_count = json["daily_request_count"].int!
                    let weekly_ticket_num = json["weekly_ticket_num"].int!
                    let daily_ticket_num = json["daily_ticket_num"].int!
                default:
                    debugPrint(response)
                    self.tokenAPI.refreshTokens()
                    self.getIngangList()
                }
            }
        }
    }
}

let dummyIngang1 = Ingang(idx: 0, day: "mon", title: "6월 27일 야간자율 학습 1타임", time: 1, request_start_date: 0, request_end_date: 1, status: false, present: 5, max_user: 9)
let dummyIngang2 = Ingang(idx: 0, day: "mon", title: "6월 27일 야간자율 학습 2타임", time: 2, request_start_date: 0, request_end_date: 1, status: true, present: 3, max_user: 9)

let ingangTime = [
    "",
    "19:50 ~ 21:10",
    "21:30 ~ 22:30"
]
