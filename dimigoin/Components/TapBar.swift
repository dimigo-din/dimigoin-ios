//
//  TapBar.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct TapBar: View {
    @Binding var index:Int
    var body: some View {
        VStack {
            HDivider()
            HStack(spacing: 50) {
                Button(action: {
                    self.index = 0
                }) {
                    VStack {
                        Image(self.index == 0 ? "doc" : "disabled-doc")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 24)
                        VSpacer(7.8)
                        Text("신청")
                            .tapBarItem()
                            .foregroundColor(self.index == 0 ? Color("Accent") : Color("Gray3"))
                        
                    }

                }
                Button(action: {
                    self.index = 1
                }) {
                    VStack {
                        Image(self.index == 1 ? "headphone" : "disabled-headphone")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 24)
                        VSpacer(7.8)
                        Text("인강실")
                            .tapBarItem()
                            .foregroundColor(self.index == 1 ? Color("Accent") : Color("Gray3"))
                        
                    }

                }
                Button(action: {
                    self.index = 2
                }) {
                    VStack {
                        Image(self.index == 2 ? "home" : "disabled-home")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 24.2)
                        VSpacer(7.8)
                        Text("메인")
                            .tapBarItem()
                            .foregroundColor(self.index == 2 ? Color("Accent") : Color("Gray3"))
                        
                    }

                }
                Button(action: {
                    self.index = 3
                }) {
                    VStack {
                        Image(systemName: "seal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 24.2)
                            .foregroundColor(self.index == 3 ? Color("Accent") : Color("Gray3"))
                        VSpacer(7.8)
                        Text("급식")
                            .tapBarItem()
                            .foregroundColor(self.index == 3 ? Color("Accent") : Color("Gray3"))
                        
                    }

                }
                Button(action: {
                    self.index = 4
                }) {
                    VStack {
                        Image(systemName: "questionmark.square.dashed")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 24.2)
                            .foregroundColor(self.index == 4 ? Color("Accent") : Color("Gray3"))
                        VSpacer(7.8)
                        Text("학생증")
                            .tapBarItem()
                            .foregroundColor(self.index == 4 ? Color("Accent") : Color("Gray3"))
                        
                    }

                }
                
            }
            .animation(.spring())
        }
    }
}
