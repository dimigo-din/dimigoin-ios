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
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 19) {
                    VStack {
                        Button(action: {
                            self.currentLocation = 0
                        }) {
                            Circle()
                                .fill(currentLocation == 0 ? Color("Accent") : Color.white)
                                .frame(width: 40, height: 40)
                                .shadow(color: Color("Gray4").opacity(0.12), radius: 5, x: 0, y: 0)
                                .overlay(
                                    Image(currentLocation == 0 ? "class-white" : "class")
                                )
                        }
                        VSpacer(9)
                        Text("교실").caption1()
                    }
                    VStack {
                        Button(action: {
                            self.currentLocation = 1
                        }) {
                            Circle()
                                .fill(currentLocation == 1 ? Color("Accent") : Color.white)
                                .frame(width: 40, height: 40)
                                .shadow(color: Color("Gray4").opacity(0.12), radius: 5, x: 0, y: 0)
                                .overlay(
                                    Image(currentLocation == 1 ? "crossmark-white" : "crossmark")
                                )
                        }
                        VSpacer(9)
                        Text("안정실").caption1()
                    }
                    
                    VStack {
                        Button(action: {
                            self.currentLocation = 2
                        }) {
                            Circle()
                                .fill(currentLocation == 2 ? Color("Accent") : Color.white)
                                .frame(width: 40, height: 40)
                                .shadow(color: Color("Gray4").opacity(0.12), radius: 5, x: 0, y: 0)
                                .overlay(
                                    Image(currentLocation == 2 ? "headphone-white" : "headphone")
                                )
                        }
                        VSpacer(9)
                        Text("인강실").caption1()
                    }
                    VStack {
                        Button(action: {
                            self.currentLocation = 3
                        }) {
                            Circle()
                                .fill(currentLocation == 3 ? Color("Accent") : Color.white)
                                .frame(width: 40, height: 40)
                                .shadow(color: Color("Gray4").opacity(0.12), radius: 5, x: 0, y: 0)
                                .overlay(
                                    Image(currentLocation == 3 ? "laundry-white" : "laundry")
                                )
                        }
                        VSpacer(9)
                        Text("세탁").caption1()
                    }
                    VStack {
                        Button(action: {
                            self.currentLocation = 4
                        }) {
                            Circle()
                                .fill(currentLocation == 4 ? Color("Accent") : Color.white)
                                .frame(width: 40, height: 40)
                                .shadow(color: Color("Gray4").opacity(0.12), radius: 4, x: 0, y: 0)
                                .overlay(
                                    Image(currentLocation == 4 ? "club-white" : "club")
                                )
                        }
                        VSpacer(9)
                        Text("동아리").caption1()
                    }
                    VStack {
                        Button(action: {
                            self.currentLocation = 5
                        }) {
                            Circle()
                                .fill(currentLocation == 5 ? Color("Accent") : Color.white)
                                .frame(width: 40, height: 40)
                                .shadow(color: Color("Gray4").opacity(0.12), radius: 5, x: 0, y: 0)
                                .overlay(
                                    Image(currentLocation == 5 ? "etc-white" : "etc")
                                )
                        }
                        VSpacer(9)
                        Text("기타").caption1()
                    }
                }.padding(.top, 5).padding(.leading, 20)
            }
        }
        VSpacer(19)
        HDivider()
    }
}

struct HDivider: View {
    let color: Color = Color("Gray8")
    let width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
