//
//  User.swift
//  dimigoin
//
//  Created by 변경민 on 2020/07/25.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation
import Alamofire

struct User: Codable, Identifiable {
    var name: String
    var id: String
    var idx: Int
    var grade: String
    var klass: String
    var number: String
    var serial: String
    var photo: String = "person.crop.circle"
    var email: String
    var weekly_request_count: Int
    var daily_request_count: Int
    var weekly_ticket_num: Int
    var daily_ticket_num: Int
}

class UserDataAPI: ObservableObject {
    @Published var user = User(name: "",
                               id: "",
                               idx: 0,
                               grade: "",
                               klass: "",
                               number: "",
                               serial: "",
                               photo: "",
                               email: "",
                               weekly_request_count: 0,
                               daily_request_count: 0,
                               weekly_ticket_num: 0,
                               daily_ticket_num: 0)
    
    init() {
        getUserData()
    }
    func getUserData() {
        let headers: HTTPHeaders = [
            "Authorization": ""
        ]
        let url: String = "https://api.dimigo.in/auth/jwt/"
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).response { response in
            if let status = response.response?.statusCode {
                switch(status) {
                case 200:
                    guard let data = response.data else { return }
                    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                    self.tokens.token = json["token"] as! String
//                default:
//                    self.tokenStatus = .fail
                default: return 
                }
            }
        }
    }
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
                          photo: "person.crop.circle",
                          email: "bkm.change.min@gmail.com",
                          weekly_request_count: 0,
                          daily_request_count: 0,
                          weekly_ticket_num: 5,
                          daily_ticket_num: 2)
