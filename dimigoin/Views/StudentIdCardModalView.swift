//
//  StudentIdCardModalView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/14.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit
import SDWebImageSwiftUI

struct StudentIdCardModalView: View {
    @Binding var isShowing: Bool
    @EnvironmentObject var userAPI: UserAPI
    @State var dragOffset = CGSize.zero
    @State var startPos = CGPoint(x: 0, y:0)
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Rectangle().fill(Color("gray2")).edgesIgnoringSafeArea(.all).opacity(isShowing ? 0.7 : 0).animation(.spring())
                    .onTapGesture {
                        withAnimation(.spring()) {
                            self.isShowing = false
                        }
                    }
                VStack {
                    ZStack {
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.isShowing.toggle()
                                }) {
                                    Image(systemName: "xmark").resizable().aspectRatio(contentMode: .fit).frame(width: 16)
                                        .foregroundColor(Color("gray1")).padding()
                                }.accessibility(identifier: "button.dismissIdCard")
                            }
                            userAPI.userPhoto.resizable().placeholder(Image("user.photo.sample")).aspectRatio(contentMode: .fit).frame(width: 131)
                                .overlay(Rectangle().stroke(Color.gray.opacity(0.15), lineWidth: 3))
                            Text(userAPI.user.name).font(Font.custom("NotoSansKR-Bold", size: 25))
                            VSpacer(14)
                            HStack {
                                VStack(alignment: .leading, spacing: 8){
                                    Text("학과").infoText().gray6()
                                    Text("학번").infoText().gray6()
        //                            Text("주민번호").infoText().gray6()
                                }
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(getMajor(klass: userAPI.user.klass)).infoText()
                                    Text(String(userAPI.user.serial)).infoText()
        //                            Text("030418-3******").infoText()
                                }
                            }
                            VSpacer(15)
                            Text("위 사람은 본교 학생임을 증명함.").font(Font.custom("NotoSansKR-Bold", size: 14))
                            Image("dimigo-logo").resizable().aspectRatio(contentMode: .fit).frame(width: 263)
        //                    Image("qr-sample").resizable().aspectRatio(contentMode: .fit).frame(width: 239)
                            Spacer()
                        }
                    }
                    
                }
                .frame(width: 300, height: 480)
                .background(
                    CustomBox(edgeInsets: .bottom, accentColor: Color("accent"), width: 13, tl: 10, tr: 10, bl: 10, br: 10)
                )
                .offset(y: (isShowing ? 0 : geometry.size.height) + dragOffset.height)
                .animation(.spring())
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.dragOffset = gesture.translation
                            self.startPos = gesture.location
                        }
                        .onEnded { gesture in
                            let xDist =  abs(gesture.location.x - self.startPos.x)
                            let yDist =  abs(gesture.location.y - self.startPos.y)
                            if self.startPos.y <  gesture.location.y && yDist > xDist {
                                if abs(self.dragOffset.height) > 100 {
                                    self.isShowing.toggle()
                                    self.dragOffset = .zero
                                } else {
                                    self.dragOffset = .zero
                                }
                            } else {
                                self.dragOffset = .zero
                            }
                        }
                )
            }
        }
    }
}
