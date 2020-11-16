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
    @ObservedObject var ingangAPI: IngangAPI
    @ObservedObject var tokenAPI: TokenAPI
    @ObservedObject var alertManager: AlertManager
    @State private var showingCustomWindow = false
    
    var body: some View {
        if(isWeekday()) {
            if(ingangAPI.ingangs.count == 0) {
                if #available(iOS 14.0, *) {
                    ScrollView(showsIndicators: false) {
                        HStack {
                            ViewTitle("인강실", sub: "")
                            Spacer()
                            Image("headphone").resizable().aspectRatio(contentMode: .fit).frame(height: 40)
                        }.horizonPadding()
                        .padding(.top, 40)
                        HDivider().horizonPadding()
                        ProgressView()
                    }
                    
                } else {
                    // Fallback on earlier versions
                }
            }
            else {
                ScrollView(showsIndicators: false) {
                    HStack {
                        ViewTitle("인강실", sub: "")
                        Spacer()
                        Image("headphone").resizable().aspectRatio(contentMode: .fit).frame(height: 40)
                    }.horizonPadding()
                    .padding(.top, 40)
                    ForEach(ingangAPI.ingangs, id: \.self) { ingang in
                        IngangItem(ingangAPI: ingangAPI, tokenAPI: tokenAPI, ingang: ingang, alertManager: alertManager)
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
                    Image("Logo").resizable().aspectRatio(contentMode: .fit).frame(width: 100).opacity(0.3)
                    Text("오늘은 인강이 없습니다!").body().gray4()
                }.offset(y: -30)
                Spacer()
            }
        }
    }
}

