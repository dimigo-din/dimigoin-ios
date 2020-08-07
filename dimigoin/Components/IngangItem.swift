//
//  IngangItem.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import SPAlert

struct IngangItem: View {
    @ObservedObject var ingangAPI: IngangAPI
    @State var ingang: Ingang
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text(self.ingang.title).highlight().headline()
                    Text(ingangTime[self.ingang.time]).caption2()

                }
                VSpacer(10)
                HStack {
                    Text("현원 \(self.ingang.present)명 / 총원 \(self.ingang.max_user)명").body()
                    Spacer()
                    if !self.ingang.status {
                        Button(action: {
                            self.ingang.status.toggle()
                            let ingangStatus = ingangAPI.applyIngang(idx: ingang.idx)
                            var message = ""
                            switch ingangStatus {
                                case .success: message = "인강실 신청 완료"
                                case .usedAllTicket: message = "오늘(일주일)치 신청을 모두 했습니다"
                                case .noIngang: message = "인강실 신청이 없습니다"
                                case .timeout: message = "신청 시간이 아닙니다"
                                case .blacklisted: message = "인강실 블랙리스트이므로 신청할 수 없습니다"
                                case .full: message = "이미 신청을 했거나 신청인원이 꽉 찼습니다"
                            }
                            if(ingangStatus != .success) {
                                self.ingang.status.toggle()
                                SPAlert.present(title: "신청 실패", message: message, preset: .privacy)
                            }
                            else {
                                SPAlert.present(title: "신청 완료", preset: .done)
                            }
                        }) {
                            Text("신청하기")
                        }
                    } else {
                        Button(action: {
                            self.ingang.status.toggle()
                            let ingangStatus = ingangAPI.cancelIngang(idx: ingang.idx)
                            var message = ""
                            switch ingangStatus {
                                case .success: message = "인강실 신청 완료"
                                case .usedAllTicket: message = "반 또는 학년이 맞지 않습니다"
                                case .noIngang: message = "인강실 또는 신청이 없습니다"
                                case .timeout: message = "신청 시간이 아닙니다"
                                case .blacklisted: message = ""
                                case .full: message = ""
                            }
                            if(ingangStatus != .success) {
                                self.ingang.status.toggle()
                                SPAlert.present(title: "인강 취소 실패", message: message, preset: .privacy)
                            }
                            else {
                                SPAlert.present(title: "인강 취소 완료", preset: .done)
                            }
                            // refresh api data
                            // cancel ingang
                        }) {
                            Text("취소하기")
                                .foregroundColor(Color("DisabledButton"))
                        }
                    }
                }
            }
        }.CustomBox()
    }
}

//struct IngangItem_Previews: PreviewProvider {
//    static var previews: some View {
//        IngangItem(ingang: dummyIngang1)
//            .padding()
//            .previewLayout(.sizeThatFits)
//    }
//}
