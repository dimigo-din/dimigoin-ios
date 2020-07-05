//
//  IngangRow.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct IngangRow: View {
    @State var ingangs: [Ingang]
    
    var body: some View {
        VStack {
            HStack {
                Text("인강실 목록").sectionHeader()
                Spacer()
                NavigationLink(destination: IngangListView()) {
                    Text("자세히 보기")
                }
            }
            VSpacer(15)
            VStack(spacing: 15.0) {
                ForEach(self.ingangs, id: \.self) { ingang in
                    IngangItem(ingang: ingang)
                }
            }
        }
    }
}

struct IngangRow_Previews: PreviewProvider {
    static var previews: some View {
        IngangRow(ingangs: [dummyIngang1, dummyIngang2])
            .previewLayout(.sizeThatFits)
    }
}
