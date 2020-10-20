//
//  IngangRow.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct IngangRow: View {
    @ObservedObject var ingangAPI: IngangAPI
    @ObservedObject var tokenAPI: TokenAPI
    
    var body: some View {
        if(ingangAPI.ingangs.count != 0) {
            VStack {
                HStack {
                    Text("인강실 목록").sectionHeader()
                    Spacer()
                    NavigationLink(destination: IngangListView(ingangAPI: ingangAPI, tokenAPI: tokenAPI)) {
                        Text("자세히 보기").caption1()
                    }
                }
                VSpacer(15)
                VStack(spacing: 15.0) {
                    ForEach(self.ingangAPI.ingangs, id: \.self) { ingang in
                        IngangItem(ingangAPI: ingangAPI, tokenAPI: tokenAPI, ingang: ingang)
                    }
                }
            }.padding()
        } else {
            Text("오늘은 인강이 없습니다!").body().opacity(0.4).padding()
        }
        
    }
}

//struct IngangRow_Previews: PreviewProvider {
//    static var previews: some View {
//        IngangRow(ingangs: [dummyIngang1, dummyIngang2])
//            .previewLayout(.sizeThatFits)
//    }
//}
