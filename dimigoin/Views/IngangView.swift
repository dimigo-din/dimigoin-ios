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
  
    @State private var showingCustomWindow = false
    var body: some View {
        ScrollView {
            ViewTitle("인강실", sub: "", img: "headphone")
            ForEach(ingangAPI.ingangs, id: \.self) { ingang in
                IngangItem(ingangAPI: ingangAPI, tokenAPI: tokenAPI, ingang: ingang)
            }
        }
    }
}

