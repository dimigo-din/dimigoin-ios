//
//  IngangListView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct IngangListView: View {
    @ObservedObject var ingangAPI: IngangAPI
    @ObservedObject var tokenAPI: TokenAPI
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15.0) {
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("신청 정보").sectionHeader()
                    HStack {
                        Text("이번 주 잔여 티켓").highlight().headline()
                        Text("\(ingangAPI.weekly_ticket_num)개")
                    }.CustomBox()
                    ForEach(ingangAPI.ingangs, id: \.self) { ingang in
                        if(ingang.status == true) {
                            IngangItem(ingangAPI: ingangAPI, tokenAPI: tokenAPI, ingang: ingang)
                        }
                    }
                }.padding()
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("인강실 목록").sectionHeader()
                    ForEach(ingangAPI.ingangs, id: \.self) { ingang in
                        IngangItem(ingangAPI: ingangAPI, tokenAPI: tokenAPI, ingang: ingang)
                    }
                }.padding()
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("우리반 신청자").sectionHeader()
                    HStack(alignment: .center) {
                        Text("1타임").highlight().headline()
                        ForEach(ingangAPI.applicants, id: \.self) { applicant in
                            Text(applicant.name).disabled().caption1()
                        }
                    }.CustomBox()
                }.padding()
                Divider().padding(.horizontal)
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("신청 안내").font(.headline)
                    Text("인강실에서는 인터넷 강의, 교과 과제, 프로그래밍 등 학습 관련 활동만 가능합니다.").caption2()
                    Text("쾌적한 인터넷 환경을 위해 과제와 관련 없는 기타 활동은 금지됩니다. 와이파이는 모두가 이용하는 공공재입니다.").caption2()
                    Text("신청 시간은 07:00 ~ 08:15입니다. 신청시간을 꼭 지켜주세요").caption2()
                }.padding(.horizontal)
                Spacer()
            }
        }
        .navigationBarTitle("오늘의 인강실")
    }
}
