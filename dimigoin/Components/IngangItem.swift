//
//  IngangItem.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct IngangItem: View {
    @State var ingang: Ingang
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text(self.ingang.title)
                        .modifier(HeadlineModifier())
                    Text(ingangTime[self.ingang.time])
                        .font(.caption)

                }
                
                Spacer().frame(height: 10.0)
                
                HStack {
                    Text("현원 \(self.ingang.present)명 / 총원 \(self.ingang.max_user)명")

                    Spacer()

                    if !self.ingang.status {
                        Button(action: {}) {
                            Text("신청하기")
                        }
                    } else {
                        Button(action: {}) {
                            Text("취소하기")
                                .foregroundColor(Color("DisabledButton"))
                        }
                    }
                }
            }
        }
        .modifier(RoundBoxModifier())
    }
}

struct IngangItem_Previews: PreviewProvider {
    static var previews: some View {
        IngangItem(ingang: dummyIngang1)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
