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
    @ObservedObject var userAPI: UserAPI
    var body: some View {
        ScrollView {
            VStack(spacing: 15.0) {
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("신청 안내").headline()
                    Text("인강실에서는 인터넷 강의, 교과 과제, 프로그래밍 등 학습 관련 활동만 가능합니다.").caption2()
                    Text("쾌적한 인터넷 환경을 위해 과제와 관련 없는 기타 활동은 금지됩니다. 와이파이는 모두가 이용하는 공공재입니다.").caption2()
                    Text("신청 시간은 07:00 ~ 08:15입니다. 신청시간을 꼭 지켜주세요").caption2()
                }
                Divider()
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("신청 정보").font(.headline)
                    HStack {
                        Text("잔여 티켓").highlight().headline()
                        Text("\(userAPI.user.daily_ticket_num)개 / \(userAPI.user.weekly_ticket_num)개")
                    }.CustomBox()
                }
                Divider()
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("인강실 목록").font(.headline)
                    ForEach(ingangAPI.ingangs, id: \.self) { ingang in
                        IngangItem(ingang: ingang)
                    }
                }
                Divider()
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("우리반 신청자").font(.headline)

                    HStack {
                        Text("1타임").highlight().headline()
                        ForEach(ingangAPI.applicants, id: \.self) { applicant in
                            Text(applicant.name)
                        }
                    }.CustomBox()
                    
                    HStack {
                        Text("2타임").highlight().headline()
                        ForEach(ingangAPI.applicants, id: \.self) { applicant in
                            Text(applicant.name)
                        }
                    }.CustomBox()
                }
                Spacer()
            }.padding()
        }
        .navigationBarTitle("오늘의 인강실")
    }
}

//struct IngangListView_Previews: PreviewProvider {
//    static var previews: some View {
//        IngangListView()
//    }
//}
