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
                    Text("\(noticeAPI.notices[0].content)")
                        .mealMenu()
                        .padding()
                        .frame(width: abs(geometry.size.width-40))
                        .background(CustomBox())
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
            
            }
            .navigationBarTitle("내정보")
            .navigationBarHidden(true)
        }
        
    }
}
