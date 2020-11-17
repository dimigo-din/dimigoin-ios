//
//  IngangItem.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import Alamofire
import DimigoinKit

struct IngangItem: View {
    @EnvironmentObject var ingangAPI: IngangAPI
    @EnvironmentObject var tokenAPI: TokenAPI
    @EnvironmentObject var alertManager: AlertManager
    @State var ingang: Ingang
    
    var body: some View {
        VStack {
            HDivider().horizonPadding()
            VSpacer(20)
            SectionHeader(ingang.title!, sub: ingangTime[ingang.time!])
            VSpacer(10)
            HStack {
                VStack {
                    Text("\(ingang.present!)").font(Font.custom("NotoSansKR-Bold", size: 40))
                    Text("현원").font(Font.custom("NotoSansKR-Bold", size: 15))
                }.foregroundColor(ingang.present == ingang.max_user ? (ingang.status! ? Color("gray4") : Color("accent")) : Color.black)
                HSpacer(130)
                VStack {
                    Text("\(ingang.max_user!)").font(Font.custom("NotoSansKR-Bold", size: 40))
                    Text("총원").font(Font.custom("NotoSansKR-Bold", size: 15))
                }
            }.modifier(CardViewModifier(UIScreen.screenWidth-40, 120))
            VSpacer(10)
            if !ingang.status! {
                Button(action: {
                    print("apply ingang : \(ingang.idx!)")
                    tokenAPI.refreshTokens()
                    let headers: HTTPHeaders = [
                        "Authorization":"Bearer \(tokenAPI.tokens.token)"
                    ]
                    let parameters: [String: String] = [
                        "ingang_idx": "\(String(ingang.idx!))"
                    ]
                    let url = "https://api.dimigo.in/ingang/"
                    AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
                        if let status = response.response?.statusCode {
                            switch(status) {
                            case 200: //success
                                alertManager.createAlert("신청이 완료되었습니다", sub: "해당 탭에서 신청 목록을 확인하실 수 있습니다", .success)
                                self.ingang.status!.toggle()
                            case 403: // 본인 학년&반 인강실이 아니거나 오늘(일주일)치 신청을 모두 했습니다.
                                alertManager.createAlert("신청에 실패했습니다", sub: "오늘(일주일)치 신청을 모두 했습니다.", .warning)
                            case 404: //인강실 신청이 없습니다.
                                alertManager.createAlert("신청에 실패했습니다", sub: "인강실 신청이 없습니다.", .danger)
                            case 405: // 신청 시간이 아닙니다
                                alertManager.createAlert("신청에 실패했습니다", sub: "인강 신청 시간이 아닙니다.", .danger)
                            case 406: // 인강실 블랙리스트이므로 신청할 수 없습니다.
                                alertManager.createAlert("신청에 실패했습니다", sub: "인강실 블랙리스트이므로 신청할 수 없습니다.", .danger)
                            case 409: // 이미 신청을 했거나 신청인원이 꽉 찼습니다.
                                alertManager.createAlert("신청에 실패했습니다", sub: "이미 신청을 했거나 신청인원이 꽉 찼습니다.", .danger)
                            case 500: // some error occured
                                alertManager.createAlert("신청에 실패했습니다", sub: "디미고인 시스템이 망가진거 같아요", .warning)
                            default:
                                alertManager.createAlert("오류가 발생했습니다.", sub: "다시시도해주세요", .warning)
                                self.tokenAPI.refreshTokens()
                                debugPrint(response)
                            }
                            ingangAPI.getTickets()
                            ingangAPI.getIngangList()
                            ingangAPI.getApplicantList()
                        }
//                        alertManager.present("test", sub: "TEST", .cancel)
                    }
                }) {
                    Text("신청하기").RSquareButton(UIScreen.screenWidth - 40, 47)
                }
            } else {
                Button(action: {
                    print("cancel ingang : \(ingang.idx!)")
                    tokenAPI.refreshTokens()
                    let headers: HTTPHeaders = [
                        "Authorization":"Bearer \(tokenAPI.tokens.token)"
                    ]
                    let parameters: [String: String] = [
                        "ingang_idx": "\(String(ingang.idx!))"
                    ]
                    let url = "https://api.dimigo.in/ingang/\(String(ingang.idx!))/"
                    AF.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
                        if let status = response.response?.statusCode {
                            switch(status) {
                            case 200: //success
                                alertManager.createAlert("취소가 완료되었습니다", sub: "해당 탭에서 신청 목록을 확인하실 수 있습니다", .cancel)
                                ingang.status!.toggle()
                            case 403: // 본인 학년&반 인강실이 아니거나 오늘(일주일)치 신청을 모두 했습니다.
                                alertManager.createAlert("취소에 실패했습니다", sub: "오늘(일주일)치 신청을 모두 했습니다.", .danger)
                            case 404: //인강실 신청이 없습니다.
                                alertManager.createAlert("취소에 실패했습니다", sub: "디미고인 시스템이 망가진거 같아요", .warning)
                            case 405: // 신청 시간이 아닙니다
                                alertManager.createAlert("취소에 실패했습니다", sub: "인강 신청(취소) 시간이 아닙니다.", .danger)
                            case 500: // some error occured
                                alertManager.createAlert("취소에 실패했습니다", sub: "디미고인 시스템이 망가진거 같아요", .danger)
                            default:
                                alertManager.createAlert("오류가 발생했습니다.", sub: "다시시도해주세요", .warning)
                                self.tokenAPI.refreshTokens()
                                debugPrint(response)
                            }
                            ingangAPI.getTickets()
                            ingangAPI.getIngangList()
                            ingangAPI.getApplicantList()
                        }
                    }
                }) {
                    Text("취소하기").DisabledRSquareButton(UIScreen.screenWidth - 40, 47)
                }
            }
        }
    }
}

//struct IngangItem_Previews: PreviewProvider {
//    static var previews: some View {
//        IngangItem(ingang: dummyIngang1)
//            .padding()
//            .previewLayout(.sizeThatFits)
//    }
//}
