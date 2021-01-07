//
//  IngangVIew.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/09.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import DimigoinKit


struct IngangView: View {
    @EnvironmentObject var ingangAPI: IngangAPI
    @EnvironmentObject var alertManager: AlertManager
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                HStack {
                    ViewTitle("인강실", sub: "")
                    Spacer()
                    Image("headphone").resizable().aspectRatio(contentMode: .fit).frame(height: 40)
                }.horizonPadding()
                .padding(.top, 40)
                HDivider().horizonPadding().offset(y: -15)
                VSpacer(10)
                ForEach(ingangAPI.ingangs, id: \.self) { ingang in
                    SectionHeader(ingang.title, sub: ingang.timeString)
                    VSpacer(10)
                    HStack {
                        VStack {
                            Text("\(ingang.applicants.count)").font(Font.custom("NotoSansKR-Bold", size: 40))
                            Text("현원").font(Font.custom("NotoSansKR-Bold", size: 15))
                        }
                        .foregroundColor(ingang.applicants.count == ingangAPI.ingangMaxApplier ? (ingang.isApplied ? Color("gray4") : Color("accent")) : Color("text"))
                        HSpacer(130)
                        VStack {
                            Text("\(ingangAPI.ingangMaxApplier)").font(Font.custom("NotoSansKR-Bold", size: 40))
                            Text("총원").font(Font.custom("NotoSansKR-Bold", size: 15))
                        }
                    }.modifier(CardViewModifier(geometry.size.width - 40, 120))
                    VSpacer(10)
                    if (ingang.applicants.count == ingangAPI.ingangMaxApplier && ingang.isApplied == false) {
                        Text("신청불가").DisabledRSquareButton(geometry.size.width - 40, 47)
                    }
                    else {
                        if !ingang.isApplied {
                            Button(action: {
                                LOG("apply ingang : \(getToday8DigitDateString())-\(ingang.time.rawValue)")
                                let headers: HTTPHeaders = [
                                    "Authorization":"Bearer \(ingangAPI.tokenAPI.accessToken)"
                                ]
                                let parameters: [String: String] = [
                                    "time": "\(ingang.time.rawValue)"
                                ]
                                let endPoint = "/ingang-application"
                                let method: HTTPMethod = .post
                                
                                AF.request(rootURL+endPoint, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
                                    if let status = response.response?.statusCode {
                                        switch(status) {
                                        case 200: //success
                                            alertManager.createAlert("인강을 신청했습니다.", sub: "오늘 \(ingang.title)에 인강실을 사용하실 수 있습니다.", .success)
                                            LOG("인강 신청 성공 : 200")
                                        case 403: // 최대 인강실 인원을 초과했습니다.
                                            alertManager.createAlert("인강 신청에 실패했습니다.", sub: "최대 인강실 인원을 초과하였습니다.", .danger)
                                            LOG("인강 신청 실패 : 403")
                                        case 404: // 해당 시간 신청한 인강실이 없습니다.
                                            alertManager.createAlert("인강 신청에 실패했습니다.", sub: "해당 시간 신청 가능한 인강실이 없습니다.", .danger)
                                            LOG("인강이 없음 : 404")
                                        case 409: //이미 해당 시간 인강실을 신청했습니다.
                                            alertManager.createAlert("인강 신청에 실패했습니다.", sub: "이미 해당 시간 인강실을 신청했습니다.", .danger)
                                            LOG("인강 이미 신청: 409")
                                        case 500:
                                            alertManager.createAlert("오류가 발생했습니다.", sub: "이 알림이 계속 나타난다면 관리자에게 문의하세요", .warning)
                                            LOG("500")
                                        default:
                                            if debugMode {
                                                debugPrint(response)
                                            }
                                            self.ingangAPI.tokenAPI.refreshTokens()
                                            _ = ingangAPI.applyIngang(time: ingang.time)
                                        }
                                    }
                                }
                            }) {
                                Text("신청하기").RSquareButton(geometry.size.width - 40, 47)
                            }
                        } else {
                            Button(action: {
                                LOG("cancel ingang : \(getToday8DigitDateString())-\(ingang.time.rawValue)")
                                let headers: HTTPHeaders = [
                                    "Authorization":"Bearer \(ingangAPI.tokenAPI.accessToken)"
                                ]
                                let parameters: [String: String] = [
                                    "time": "\(ingang.time.rawValue)"
                                ]
                                let endPoint = "/ingang-application"
                                let method: HTTPMethod = .delete
                                AF.request(rootURL+endPoint, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
                                    if let status = response.response?.statusCode {
                                        switch(status) {
                                        case 200: //success
                                            alertManager.createAlert("인강을 취소했습니다.", sub: "인강실을 이용하시려면 다시 신청을 해주시기 바랍니다.", .success)
                                            LOG("인강 취소 성공 : 200")
                                        case 403: // 최대 인강실 인원을 초과했습니다.
                                            alertManager.createAlert("인강 신청에 실패했습니다.", sub: "최대 인강실 인원을 초과하였습니다.", .danger)
                                            LOG("인강 신청 실패 : 403")
                                        case 404: // 해당 시간 신청한 인강실이 없습니다.
                                            alertManager.createAlert("인강 취소에 실패했습니다.", sub: "해당 시간 취소가능한 인강실이 없습니다.", .danger)
                                            LOG("인강이 없음 : 404")
                                        case 409: //이미 해당 시간 인강실을 신청했습니다.
                                            alertManager.createAlert("인강 취소에 실패했습니다.", sub: "이미 해당 시간 인강실을 취소했습니다.", .danger)
                                            LOG("인강 이미 취소: 409")
                                        case 500:
                                            alertManager.createAlert("오류가 발생했습니다.", sub: "이 알림이 계속 나타난다면 관리자에게 문의하세요", .warning)
                                            LOG("500")
                                        default:
                                            if debugMode {
                                                debugPrint(response)
                                            }
                                            self.ingangAPI.tokenAPI.refreshTokens()
                                            _ = ingangAPI.applyIngang(time: ingang.time)
                                        }
                                    }
                                }
                            }) {
                                Text("취소하기").DisabledRSquareButton(geometry.size.width - 40, 47)
                            }
                        }
                    }
                    VSpacer(20)
                }
                SectionHeader("우리반 신청자", sub: "")
                ForEach(ingangAPI.ingangs, id: \.self) { ingang in
                    HStack {
                        Text("\(ingang.time == .NSS1 ? 1 : 2)타임").font(Font.custom("NotoSansKR-Medium", size: 15)).padding(.horizontal, 5)
                        Divider()
                        Text("\(ingang.getApplicantStringList())").font(Font.custom("NotoSansKR-Regular", size: 13)).gray4().lineSpacing(12)
                        Spacer()
                            
                    }.padding()
                    .frame(width: abs(geometry.size.width-40), alignment: .leading)
                    .background(CustomBox())
                    .fixedSize(horizontal: false, vertical: true)
                }
                VSpacer(20)
            }
        }
    }
}
