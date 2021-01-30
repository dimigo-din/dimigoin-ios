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
    @EnvironmentObject var api: DimigoinAPI
    @EnvironmentObject var alertManager: AlertManager
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                ViewTitle("인강실", sub: "야간자율학습", icon: "headphone")
                
                ForEach(api.ingangs, id: \.self) { ingang in
                    SectionHeader(ingang.title, sub: ingang.timeString).horizonPadding()
                    VSpacer(10)
                    VStack {
                        HStack {
                            Spacer()
                            VStack {
                                Text("\(ingang.applicants.count)").font(Font.custom("NotoSansKR-Bold", size: 40))
                                Text("현원").font(Font.custom("NotoSansKR-Bold", size: 15))
                            }
                            .foregroundColor(ingang.applicants.count == ingang.maxApplier ? (ingang.isApplied ? Color.gray4 : Color.accent) : Color.text)
                            HSpacer(130)
                            VStack {
                                Text("\(ingang.maxApplier)").font(Font.custom("NotoSansKR-Bold", size: 40))
                                Text("총원").font(Font.custom("NotoSansKR-Bold", size: 15))
                            }
                            Spacer()
                        }.frame(width: geometry.size.width - 40, height: 120)
                    }.modifier(CardViewModifier(geometry.size.width - 40, 120))
                    VSpacer(10)
                    if (ingang.applicants.count == ingang.maxApplier && ingang.isApplied == false) {
                        Text("신청불가").DisabledRSquareButton(geometry.size.width - 40, 47)
                    }
                    else {
                        if !ingang.isApplied {
                            Button(action: {
                                api.applyIngang(time: ingang.time) { result in
                                    switch result {
                                    case .success(()):
                                        print("인강 신청 성공")
                                    case .failure(let error):
                                        switch error {
                                        case .alreadyApplied:
                                            self.alertManager.createAlert("신청에 실패했습니다.", sub: "이미 신청한 인강입니다.", .danger)
                                        case .full:
                                            self.alertManager.createAlert("신청에 실패했습니다.", sub: "신청 최대 인원에 도달했습니다.", .danger)
                                        case .noIngang:
                                            self.alertManager.createAlert("신청에 실패했습니다.", sub: "인강이 없습니다.", .danger)
                                        case .timeout:
                                            self.alertManager.createAlert("신청에 실패했습니다.", sub: "시간 초과", .danger)
                                        case .tokenExpired:
                                            self.alertManager.createAlert("신청에 실패했습니다.", sub: "토큰이 만료 되었습니다. 다시시도 해주세요", .danger)
                                        case .unknown:
                                            self.alertManager.createAlert("신청에 실패했습니다.", sub: "알 수 없는 에러", .danger)
                                        }
                                    }
                                }
                            }) {
                                Text("신청하기").RSquareButton(geometry.size.width - 40, 47)
                            }
                        } else {
                            Button(action: {
                                api.cancelIngang(time: ingang.time) { result in
                                    switch result {
                                    case .success(()):
                                        print("인강 취소 성공")
                                    case .failure(let error):
                                        switch error {
                                        case .alreadyApplied:
                                            self.alertManager.createAlert("신청에 실패했습니다.", sub: "이미 신청한 인강입니다.", .danger)
                                        case .full:
                                            self.alertManager.createAlert("신청에 실패했습니다.", sub: "신청 최대 인원에 도달했습니다.", .danger)
                                        case .noIngang:
                                            self.alertManager.createAlert("신청에 실패했습니다.", sub: "인강이 없습니다.", .danger)
                                        case .timeout:
                                            self.alertManager.createAlert("신청에 실패했습니다.", sub: "시간 초과", .danger)
                                        case .tokenExpired:
                                            self.alertManager.createAlert("신청에 실패했습니다.", sub: "토큰이 만료 되었습니다. 다시시도 해주세요", .danger)
                                        case .unknown:
                                            self.alertManager.createAlert("신청에 실패했습니다.", sub: "알 수 없는 에러", .danger)
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
                VSpacer(100)
            }
        }
    }
}
