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
                                // apply ingang
                            }) {
                                Text("신청하기").RSquareButton(geometry.size.width - 40, 47)
                            }
                        } else {
                            Button(action: {
                                // cancel ingang
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
