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
                TicketStatusView(api: api, geometry: geometry)
                VSpacer(30)
                ForEach(api.ingangs, id: \.self) { ingang in
                    VStack(spacing: 0) {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(ingang.timeString).notoSans(.bold, size: 10, Color.accent)
                                Text(ingang.title).notoSans(.bold, size: 21)
                            }
                            Spacer()
                        }
                    }
                    .horizonPadding()
                    VSpacer(10)
                    HStack {
                        ForEach(1...4, id: \.self) { row in
                            VStack(spacing: 14) {
                                ForEach(0...1, id: \.self) { col in
                                    if api.getApplicant(ingang.time, col*4+row).name == "" {
                                        Text("신청가능")
                                            .notoSans(.medium, size: 12, Color("gray6"))
                                    } else {
                                        Text("\(api.getApplicant(ingang.time, col*4+row).name)")
                                            .notoSans(.medium, size: 12, Color("gray3"))
                                    }
                                }
                            }
                            if row != 4 {
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    .frame(width: abs(geometry.size.width - 40), height: 89)
                    .modifier(CardViewModifier(geometry.size.width - 40, 89))
                    VSpacer(10)
                    if ingang.applicants.count == ingang.maxApplier && ingang.isApplied == false {
                        Text("신청불가")
                            .notoSans(.bold, size: 13, Color.white)
                            .frame(width: geometry.size.width - 40, height: 45)
                            .background(Color.gray4.cornerRadius(10))
                    } else {
                        if !ingang.isApplied {
                            Button(action: {
                                applyIngang(ingang: ingang)
                            }) {
                                Text("신청하기")
                                    .notoSans(.bold, size: 13, Color.white)
                                    .frame(width: geometry.size.width - 40, height: 45)
                                    .background(Color.accent.cornerRadius(10))
                            }
                        } else {
                            Button(action: {
                                cancelIngang(ingang: ingang)
                            }) {
                                Text("취소하기")
                                    .notoSans(.bold, size: 13, Color.white)
                                    .frame(width: geometry.size.width - 40, height: 45)
                                    .background(Color.gray4.cornerRadius(10))
                            }
                        }
                    }
                    VSpacer(30)
                }
                if api.ingangs.count == 0 {
                    Text("오늘은 인강이 없습니다").notoSans(.regular, size: 13, Color.gray4)
                }
                VSpacer(100)
            }
        }
    }
    func applyIngang(ingang: Ingang) {
        api.applyIngang(time: ingang.time) { result in
            switch result {
            case .success(()):
                print("인강 신청 성공")
                api.fetchIngangData { }
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
    }
    func cancelIngang(ingang: Ingang) {
        api.cancelIngang(time: ingang.time) { result in
            switch result {
            case .success(()):
                print("인강 취소 성공")
                api.fetchIngangData { }
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
    }
}

struct TicketStatusView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State var api: DimigoinAPI
    @State var geometry: GeometryProxy
    var body: some View {
        VStack {
            ZStack {
                VDivider()
                HStack {
                    if horizontalSizeClass != .compact {
                        Spacer()
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Image("clock").templateImage(width: 15, Color.gray4)
                            HSpacer(8)
                            Text("07:00 - 08:15")
                                .notoSans(.bold, size: 10, Color.gray4)
                        }
                    }.padding(.leading, horizontalSizeClass == .compact ? 40 : 0)
                    Spacer()
                    VStack(alignment: .leading) {
                        HStack {
                            Image("ticket").templateImage(width: 15, Color.accent)
                            Text("남은 티켓 \(api.weeklyRemainTicket)/\(api.weeklyTicketCount)").notoSans(.bold, size: 10, Color.accent)
                        }
                    }.padding(.trailing, horizontalSizeClass == .compact ? 50 : 0)
                    if horizontalSizeClass != .compact {
                        Spacer()
                    }
                }.frame(width: abs(geometry.size.width - 40), height: 40)
            }
        }.modifier(CardViewModifier(geometry.size.width - 40, 40))
    }
}
