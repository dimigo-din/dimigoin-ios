//
//  LocationSelection.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/09.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct LocationSelectionView: View {
    @Binding var currentLocation: Int
    var body: some View {
        VStack {
            SectionHeader("자습 현황", sub: "야간자율학습 1타임")
            HStack() {
                Group {
                    LocationItem(currentLocation: $currentLocation, idx: 0, icon: "class", title: "교실")
                    Spacer()
                    LocationItem(currentLocation: $currentLocation, idx: 1, icon: "crossmark", title: "안정실")
                    Spacer()
                    LocationItem(currentLocation: $currentLocation, idx: 2, icon: "headphone", title: "인강실")
                    Spacer()
                    
                }
                Group {
                    LocationItem(currentLocation: $currentLocation, idx: 3, icon: "laundry", title: "세탁")
                    Spacer()
                    LocationItem(currentLocation: $currentLocation, idx: 4, icon: "club", title: "동아리")
                    Spacer()
                    LocationItem(currentLocation: $currentLocation, idx: 5, icon: "etc", title: "기타")
                }
                
            }.padding(.top, 5)
            .horizonPadding()
            
        }
        VSpacer(19)
        HDivider()
    }
}

struct LocationItem: View {
    @Binding var currentLocation: Int
    @State var idx: Int
    @State var icon: String
    @State var title: String
    
    var body: some View {
        VStack {
            Button(action: {
                self.currentLocation = idx
            }) {
                Circle()
                    .fill(currentLocation == idx ? Color("accent") : Color.white)
                    .frame(width: 40, height: 40)
                    .shadow(color: Color("gray4").opacity(0.12), radius: 4, x: 0, y: 0)
                    .overlay(
                        Image(currentLocation == idx ? "\(icon)-white" : "\(icon)")
                    )
            }
            VSpacer(9)
            Text("\(title)").caption1()
        }
    }
}
