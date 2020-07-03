//
//  IngangListView.swift
//  dimigoin-ios
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct IngangListView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 15.0) {
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("신청 안내").font(.headline)
                    Text("인강실에서는 인터넷 강의, 교과 과제, 프로그래밍 등 학습 관련 활동만 가능합니다.")
                        .helperText()
                    Text("쾌적한 인터넷 환경을 위해 과제와 관련 없는 기타 활동은 금지됩니다. 와이파이는 모두가 이용하는 공공재입니다.").helperText()
                }
                Divider()

                VStack(alignment: .leading, spacing: 10.0) {
                    Text("신청 정보").font(.headline)
                    HStack {
                        HStack {
                            Text("신청 시간").highlight().headline()
                            Text("07:00 ~ 08:15")
                        }

                        HStack {
                            Text("잔여 티켓").highlight().headline()
                            Text("2개 / 4개")
                        }
                    }.modifier(RoundBoxModifier())
                }
                Divider()
                
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("인강실 목록").font(.headline)
                    ForEach([dummyIngang1, dummyIngang2], id: \.self) { ingang in
                        IngangItem(ingang: ingang)
                    }
                }
                Divider()
                
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("우리반 신청자").font(.headline)

                    HStack {
                        Text("1타임").highlight().headline()
                        ForEach(0 ..< 2) { _ in
                            Text("엄서훈")
                        }
                    }.modifier(RoundBoxModifier())
                    
                    HStack {
                        Text("2타임").highlight().headline()
                        ForEach(0 ..< 4) { _ in
                            Text("여준호")
                        }
                    }.modifier(RoundBoxModifier())
                }
                Spacer()
            }.padding()
        }
        .navigationBarTitle("오늘의 인강실")
    }
}

struct IngangListView_Previews: PreviewProvider {
    static var previews: some View {
        IngangListView()
    }
}
