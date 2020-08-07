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
    @ObservedObject var userAPI: UserAPI
    
    var body: some View {
        VStack {
            HStack {
                Text("인강실 목록").sectionHeader()
                Spacer()
                NavigationLink(destination: IngangListView(ingangAPI: ingangAPI, userAPI: userAPI)) {
                    Text("자세히 보기")
                }
            }
            VSpacer(15)
            VStack(spacing: 15.0) {
                ForEach(self.ingangAPI.ingangs, id: \.self) { ingang in
                    IngangItem(ingang: ingang)
                }
            }
        }
    }
}

//struct IngangRow_Previews: PreviewProvider {
//    static var previews: some View {
//        IngangRow(ingangs: [dummyIngang1, dummyIngang2])
//            .previewLayout(.sizeThatFits)
//    }
//}
