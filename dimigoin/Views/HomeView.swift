//
//  HomeView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var currentLocation = 0
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    VStack {
                        VSpacer(70)
                        Image("School").resizable().aspectRatio(contentMode: .fit).frame(width: UIScreen.screenWidth).opacity(0.3)
                    }
                    HStack {
                        Image("Logo").resizable().aspectRatio(contentMode: .fit).frame(height: 38)
                        Spacer()
                        Button(action: {
                            // Profile View
                        }) {
                            Circle().frame(width: 38, height: 38).foregroundColor(Color.white)
                                .overlay(
                                    Circle().stroke(Color("Accent"), lineWidth: 2)
                                )
                        }
                    }.horizonPadding()
                }
                VSpacer(15)
                LocationSelectionView(currentLocation: $currentLocation)
                Text("오늘의 급식").font(Font.custom("NotoSansKR-Bold", size: 20))
            }.offset(y: -20)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
