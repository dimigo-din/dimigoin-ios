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
import Combine

struct StudentIdCardModalView: View {
    @Binding var isShowing: Bool
    @EnvironmentObject var userAPI: UserAPI
    @State var dragOffset = CGSize.zero
    @State var startPos = CGPoint(x: 0, y:0)
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var remainTime = 15
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Rectangle().fill(Color.black).edgesIgnoringSafeArea(.all).opacity(isShowing ? 1 : 0).animation(.spring())
                    .onTapGesture {
                        withAnimation(.spring()) {
                            self.isShowing = false
                        }
                    }
                VStack {
                    HStack {
                        Image("idcard").renderingMode(.template).foregroundColor(Color.white)
                        Text("MOBILE ID CARD").font(Font.custom("NotoSansKR-Bold", size: 13)).foregroundColor(Color.white)
                        Spacer()
                        Text("남은 시간").font(Font.custom("NotoSansKR-Medium", size: 13)).foregroundColor(Color.white)
                        Text("\(remainTime)").font(Font.custom("NotoSansKR-Medium", size: 13)).foregroundColor(Color.white)
                            .onReceive(timer) { input in
                                if(isShowing == true) {
                                    self.remainTime -= 1
                                    if(remainTime == 0) {
                                        withAnimation(.spring()) {
                                            self.isShowing = false
                                        }
                                    }
                                }
                            }
                    }.frame(width: 275).opacity(isShowing ? 1 : 0).padding(.top, 40)
                    Spacer()
                }
                VStack {
                    Spacer()
                    Image("dimigo-logo").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(height: 25).foregroundColor(Color.white).padding(.bottom, 60).opacity(isShowing ? 1 : 0)
                }
                VStack {
                    VStack {
                        VSpacer(40)
                        userAPI.userPhoto.resizable().placeholder(Image("user.photo.sample")).cornerRadius(5).aspectRatio(contentMode: .fit).frame(width: 116)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.15), lineWidth: 1))
                        VSpacer(25)
                        Text(userAPI.user.name).font(Font.custom("NotoSansKR-Bold", size: 21))
                        VSpacer(25)
                        HStack(spacing: 15) {
                            VStack(alignment: .trailing, spacing: 11){
                                Text("학과").font(Font.custom("NotoSansKR-Bold", size: 13)).foregroundColor(Color.black)
                                Text("학번").font(Font.custom("NotoSansKR-Bold", size: 13)).foregroundColor(Color.black)
                                Text("주민번호").font(Font.custom("NotoSansKR-Bold", size: 13)).foregroundColor(Color.black)
                            }
                            VStack(alignment: .leading, spacing: 11) {
                                Text(getMajor(klass: userAPI.user.klass)).font(Font.custom("NotoSansKR-Light", size: 13)).gray4()
                                Text(String(userAPI.user.serial)).font(Font.custom("NotoSansKR-Light", size: 13)).gray4()
                                Text("030418-3******").font(Font.custom("NotoSansKR-Light", size: 13)).gray4()
                            }
                        }
                        VSpacer(20)
                        Image("qr-sample").resizable().aspectRatio(contentMode: .fit).frame(height: 48)
                        VSpacer(15)
                        Text("위 사람은 본교 학생임을 증명함.").font(Font.custom("NotoSansKR-Bold", size: 12)).foregroundColor(Color.black)
                    }
                    
                }
                .frame(width: 275, height: 473)
                .background(
                    Rectangle().fill(Color.white).cornerRadius(10).frame(width: 275, height: 473)
                )
                .offset(y: (isShowing ? 0 : geometry.size.height) + dragOffset.height)
//                .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
//                    .onChanged { value in
//                        self.dragOffset = value.translation
//                    }
//                    .onEnded { value in
//                        self.dragOffset = .zero
//                        if value.translation.height < 0 && value.translation.width > -30 && value.translation.width < 30 {
//                            withAnimation(.spring()) {
//                                self.isShowing.toggle()
//                            }
//
//                        }
//                    }
//                )
            }
        }
    }
}
