//
//  Tokens.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum TokenStatus {
    case exist
    case none
}

struct Tokens: Codable, Identifiable {
    var id = UUID()
    var token: String = ""
    var refresh_token: String = ""
}

class TokenAPI: ObservableObject {
    @Published var tokens = Tokens()
    @Published var tokenStatus: TokenStatus = .none
    private var id: String = ""
    private var password: String = ""
    
    init() {
        checkTokenStatus()
    }
    func set(id: String, password: String) -> Void{
        self.id = id
        self.password = password
    }
    func getTokens() -> Void{
        let parameters: [String: String] = [
            "id": "\(self.id)",
            "password": "\(self.password)"
        ]
        let url: String = "https://api.dimigo.in/auth/"
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
            if let status = response.response?.statusCode {
                switch(status) {
                case 200:
                    let json = JSON(response.value!!)
                    self.tokens.token = json["token"].string!
                    self.tokens.refresh_token = json["refresh_token"].string!
                    self.debugToken()
                    self.saveTokens()
                    self.tokenStatus = .exist
                default:
                    print("get token failed")
                    debugPrint(response)
                    self.tokenStatus = .none
                }
            }
        }
    }
    func debugToken() {
        print("token : \(tokens.token)")
        print("refresh_token : \(tokens.refresh_token)")
    }
    func saveTokens() {
        UserDefaults.standard.setValue(self.tokens.token, forKey: "token")
        UserDefaults.standard.setValue(self.tokens.refresh_token, forKey: "refresh_token")
    }
    func loadTokens() {
        self.tokens.token = UserDefaults.standard.string(forKey: "token") ?? ""
        self.tokens.refresh_token = UserDefaults.standard.string(forKey: "refresh_token") ?? ""
    }
    func checkTokenStatus(){
        if UserDefaults.standard.string(forKey: "token") != nil {
            self.tokenStatus = .exist
            print("Existing tokens found")
        } else {
            tokenStatus = .none
        }
    }
    func clearTokens() {
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "refresh_token")
        self.tokenStatus = .none
        print("Remove tokens")
    }
    func refreshTokens() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.tokens.refresh_token)"
        ]
        let url = "https://api.dimigo.in/auth/token/refresh"
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).response { response in
            if let status = response.response?.statusCode {
                switch(status) {
                case 200:
                    let json = JSON(response.value!!)
                    self.tokens.token = json["token"].string!
                    self.tokens.refresh_token = json["refresh_token"].string!
                    self.debugToken()
                    self.saveTokens()
                    self.tokenStatus = .exist
                    print("Token expired, refreshed")
                default:
                    self.tokenStatus = .none
                }
            }
        }
    }
}
