//
//  AssignView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct ProfileView: View {
    @EnvironmentObject var userAPI: UserAPI
    @EnvironmentObject var tokenAPI: TokenAPI
    @EnvironmentObject var noticeAPI: NoticeAPI
    @EnvironmentObject var alertManager: AlertManager
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    HStack {
                        ViewTitle("내정보", sub: "")
                        Spacer()
                    }.horizonPadding()
                    .padding(.top, 40)
                    HDivider().horizonPadding().offset(y: -15)
                    HStack(alignment: .bottom) {
                        ZStack {
                            Text(NSLocalizedString("공지사항", comment: "")).sectionHeader()
                            Circle().fill(Color("accent")).frame(width: 8, height: 8).offset(x: 45, y: -7)
                        }
                        NavigationLink(destination: FullNoticeListView().environmentObject(noticeAPI).environmentObject(userAPI)) {
                            Text("더보기").accent().mealMenu().padding([.bottom, .leading], 4)
                        }
                        Spacer()
                    }.horizonPadding()
                    Text("\(noticeAPI.notices.count != 0 ? noticeAPI.notices[0].content : "공지사항이 없습니다.")")
                            .noticeContent()
                            .padding()
                            .frame(width: abs(geometry.size.width-40), alignment: .leading)
                            .background(CustomBox())
                            .fixedSize(horizontal: false, vertical: true)
                   
                    SectionHeader("신청 안내", sub: "")
                    HStack(alignment: .top){
                        VStack(alignment: .leading) {
                            Text("\(userAPI.user.grade)학년 신청시간").infoText()
                            HStack {
                                Image("clock")
                                Text("07:00 - 08:15").gray4().caption3()
                            }
                            HStack {
                                Image("person.2")
                                Text("한 학급당 최대 ").gray4().caption3()
                                +
                                Text("6명").bold().gray4().caption1()
                            }
                            HStack {
                                Image("calendar.empty")
                                Text("일주일 최대 ").gray4().caption3()
                                +
                                Text("4회").bold().gray4().caption1()
                            }
                        }
                        Divider()
                        VStack(alignment: .leading) {
                            Text("내 티켓").infoText()
                            HStack {
                                Image("ticket")
                                Text("남은 티켓 ").accent().caption3()
                                +
                                Text("\(userAPI.user.weeklyRemainTicket)/\(userAPI.user.weeklyTicketCount)").accent().caption1()
                            }
                            Text("티켓을 모두 소진하면 신청할 수 없습니다.").gray4().caption3()
                            Text("인강실 사용이 꼭 필요할 때만 신청하시기 바랍니다.").gray4().caption3()
                        }
                    }.padding()
                    .frame(width: abs(geometry.size.width-40), alignment: .leading)
                    .background(CustomBox())
                    .fixedSize(horizontal: false, vertical: true)
                            
                    Button(action: {
                        tokenAPI.clearTokens()
                    }) {
                        Text("로그아웃").RSquareButton(geometry.size.width-40, 50).padding(.vertical)
                    }
                    Spacer()
                }
            
            }
            .navigationBarTitle("내정보")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
