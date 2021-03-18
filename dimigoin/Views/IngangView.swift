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
                                Text(ingang.timeString).notoSans(.bold, size: 10, .accent)
                                Text(ingang.title.localized).notoSans(.bold, size: 21)
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
                                            .notoSans(.medium, size: 12, api.getApplicant(ingang.time, col*4+row).name == api.user.name ? .text : Color("gray3"))
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
                    if ingang.isFetching {
                        ProgressView()
                            .frame(width: geometry.size.width - 40, height: 45)
                            .background(Color.gray4.cornerRadius(10))
                    } else {
                        if ingang.applicants.count == ingang.maxApplier && ingang.isApplied == false {
                            Text("신청불가")
                                .notoSans(.bold, size: 13, .white)
                                .frame(width: geometry.size.width - 40, height: 45)
                                .background(Color.gray4.cornerRadius(10))
                        } else {
                            if !ingang.isApplied {
                                Button(action: {
                                    applyIngang(ingang: ingang)
                                }) {
                                    Text("신청하기")
                                        .notoSans(.bold, size: 13, .white)
                                        .frame(width: geometry.size.width - 40, height: 45)
                                        .background(Color.accent.cornerRadius(10))
                                }
                            } else {
                                Button(action: {
                                    cancelIngang(ingang: ingang)
                                }) {
                                    Text("취소하기")
                                        .notoSans(.bold, size: 13, .white)
                                        .frame(width: geometry.size.width - 40, height: 45)
                                        .background(Color.gray4.cornerRadius(10))
                                }
                            }
                        }
                    }
                    VSpacer(30)
                }
                if api.ingangs.count == 0 {
                    Text("오늘은 인강이 없습니다").notoSans(.regular, size: 13, .gray4)
                }
                VSpacer(100)
            }
        }
    }
    func applyIngang(ingang: Ingang) {
        api.applyIngang(ingang: ingang) { result in
            switch result {
            case .success(()):
                print("인강 신청 성공")
                api.fetchIngangData { }
            case .failure(let error):
                switch error {
                case .alreadyApplied:
                    Alert.present("인강 신청에 실패했습니다.", message: "이미 신청한 인강입니다.", icon: .dangermark, color: .red)
                case .full:
                    Alert.present("인강 신청에 실패했습니다.", message: "신청 최대 인원에 도달했거나 인강 신청 시간이 아닙니다.", icon: .dangermark, color: .red)
                case .noIngang:
                    Alert.present("인강 신청에 실패했습니다.", message: "인강이 없습니다.", icon: .dangermark, color: .red)
                case .noTicket:
                    Alert.present("인강 신청에 실패했습니다.", message: "이번 주 인강실 티켓을 모두 사용했습니다.", icon: .dangermark, color: .red)
                case .timeout:
                    Alert.present("인강 신청에 실패했습니다.", message: "시간 초과", icon: .dangermark, color: .red)
                case .tokenExpired:
                    Alert.present("인강 신청에 실패했습니다.", message: "토큰이 만료 되었습니다. 다시시도 해주세요", icon: .dangermark, color: .red)
                case .unknown:
                    Alert.present("인강 신청에 실패했습니다.", message: "알 수 없는 에러", icon: .dangermark, color: .red)
                }

            }
        }
    }
    func cancelIngang(ingang: Ingang) {
        api.cancelIngang(ingang: ingang) { result in
            switch result {
            case .success(()):
                print("인강 취소 성공")
                api.fetchIngangData { }
            case .failure(let error):
                switch error {
                case .alreadyApplied:
                    Alert.present("인강 취소에 실패했습니다.", message: "이미 취소한 인강입니다.", icon: .dangermark, color: .red)
                case .full:
                    Alert.present("인강 취소에 실패했습니다.", message: "신청 최대 인원에 도달했거나 인강 신청 시간이 아닙니다.", icon: .dangermark, color: .red)
                case .noIngang:
                    Alert.present("인강 취소에 실패했습니다.", message: "인강이 없습니다.", icon: .dangermark, color: .red)
                case .noTicket:
                    Alert.present("인강 취소에 실패했습니다.", message: "이번 주 인강실 티켓을 모두 사용했습니다.", icon: .dangermark, color: .red)
                case .timeout:
                    Alert.present("인강 취소에 실패했습니다.", message: "시간 초과", icon: .dangermark, color: .red)
                case .tokenExpired:
                    Alert.present("인강 취소에 실패했습니다.", message: "토큰이 만료 되었습니다. 다시시도 해주세요", icon: .dangermark, color: .red)
                case .unknown:
                    Alert.present("인강 취소에 실패했습니다.", message: "알 수 없는 에러", icon: .dangermark, color: .red)
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
                                .notoSans(.bold, size: 10, .gray4)
                        }
                    }.padding(.leading, horizontalSizeClass == .compact ? 40 : 0)
                    Spacer()
                    VStack(alignment: .leading) {
                        HStack {
                            Image("ticket").templateImage(width: 15, .accent)
                            Text("남은 티켓").notoSans(.bold, size: 10, .accent)
                            +
                            Text(" \(api.weeklyRemainTicket)/\(api.weeklyTicketCount)").notoSans(.bold, size: 10, .accent)
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
