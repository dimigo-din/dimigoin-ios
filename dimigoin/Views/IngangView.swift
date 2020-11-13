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
import SPAlert

struct IngangView: View {
    @ObservedObject var ingangAPI: IngangAPI
    @ObservedObject var tokenAPI: TokenAPI
    @ObservedObject var alertManager: AlertManager
    @State private var showingCustomWindow = false
    
    var body: some View {
        if(ingangAPI.ingangs.count == 0) {
            VStack {
                HStack {
                    ViewTitle("인강실", sub: "")
                    Spacer()
                    Image("headphone").resizable().aspectRatio(contentMode: .fit).frame(height: 40)
                }.horizonPadding()
                .padding(.top, 40)
                HDivider().horizonPadding()
                Spacer()
                ZStack {
                    Image("Logo").resizable().aspectRatio(contentMode: .fit).frame(width: 100).opacity(0.3)
                    Text("오늘은 인강이 없습니다!").body().gray4()
                }
                Spacer()
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
}

