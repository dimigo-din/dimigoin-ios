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

let dummyIngang: [Ingang] = [
    Ingang(idx: 2, day: "월", title: "33", time: 1, request_start_date: 2, request_end_date: 2, status: false, present: 3, max_user: 5),
    Ingang(idx: 2, day: "월", title: "33", time: 1, request_start_date: 2, request_end_date: 2, status: false, present: 3, max_user: 5)
]

struct IngangView: View {
    @EnvironmentObject var ingangAPI: IngangAPI
    @EnvironmentObject var alertManager: AlertManager
    
    var body: some View {
        if(isWeekday()) {
            if(ingangAPI.ingangs.count != 0) { // MARK: Change here
                VStack {
                    HStack {
                        ViewTitle("인강실", sub: "")
                        Spacer()
                        Image("headphone").resizable().aspectRatio(contentMode: .fit).frame(height: 40)
                    }.horizonPadding()
                    .padding(.top, 40)
                    HDivider().horizonPadding().offset(y: -15)
                    Spacer()
                    ZStack {
                        Image("logo").resizable().aspectRatio(contentMode: .fit).frame(width: 100).opacity(0.3)
                    }.offset(y: -30)
                    Spacer()
                }
            }
            else {
                GeometryReader { geometry in
                    ScrollView(showsIndicators: false) {
                        HStack {
                            ViewTitle("인강실", sub: "")
                            Spacer()
                            Image("headphone").resizable().aspectRatio(contentMode: .fit).frame(height: 40)
                        }.horizonPadding()
                        .padding(.top, 40)
                        ForEach(dummyIngang, id: \.self) { ingang in
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
                                }.modifier(CardViewModifier(geometry.size.width - 40, 120))
                                VSpacer(10)
                                if !ingang.status! {
                                    Button(action: { }) {
                                        Text("신청하기").RSquareButton(geometry.size.width - 40, 47)
                                    }
                                } else {
                                    Button(action: {}) {
                                        Text("취소하기").DisabledRSquareButton(geometry.size.width - 40, 47)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        else {
            VStack {
                HStack {
                    ViewTitle("인강실", sub: "")
                    Spacer()
                    Image("headphone").resizable().aspectRatio(contentMode: .fit).frame(height: 40)
                }.horizonPadding()
                .padding(.top, 40)
                HDivider().horizonPadding().offset(y: -15)
                Spacer()
                ZStack {
                    Image("logo").resizable().aspectRatio(contentMode: .fit).frame(width: 100).opacity(0.3)
                    Text("오늘은 인강이 없습니다!").body().gray4()
                }.offset(y: -30)
                Spacer()
            }
        }
    }
}

