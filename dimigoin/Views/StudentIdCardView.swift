//
//  StudentIdCardView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/10.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit
import LocalAuthentication
import SDWebImageSwiftUI

struct StudentIdCardView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @EnvironmentObject var api: DimigoinAPI
    @Binding var isShowIdCard: Bool
    @State var remainTime = 15
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    ViewTitle("학생증", sub: "모바일 학생증", icon: "idcard")
                    Spacer()
                    if ProcessInfo.processInfo.arguments.contains("UITesting") {
                        Button(action: {
                            isShowIdCard = true
                        }) {
                            Text("Test Button")
                        }.accessibility(identifier: "button.showIdCard")
                        VSpacer(100)
                    }
                }
                VStack {
                    Color.clear.frame(height: 280)
                    Button(action: {
                        Alert.readmeBeforeUseIDCard()
                    }) {
                        HStack {
                            Image("infomark").templateImage(width: 15, height: 15, .white)
                            Text("사용 전 다음 내용을 반드시 읽어주세요")
                                .notoSans(.bold, size: 11)
                                .foregroundColor(.white)
                        }.padding(.vertical, 13).frame(width: horizontalSizeClass == .compact ? abs(geometry.size.width-40) : 335).opacity(0.8).background(Color("gray6").cornerRadius(10)).padding(.bottom)
                    }
                    
                }.offset(y: isShowIdCard ? 0 : -tabBarSize/2)
                Color.black.edgesIgnoringSafeArea(.all).opacity(isShowIdCard ? 1 : 0).statusBar(hidden: isShowIdCard)
                VStack {
                    HStack {
                        Image("idcard").templateImage(width: 15, .white)
                        Text("MOBILE ID CARD").notoSans(.bold, size: 13, .white)
                        Spacer()
                        Text("남은 시간").notoSans(.medium, size: 13, .white)
                        Text("\(remainTime)").notoSans(.black, size: 13, .white)
                            .onReceive(timer) { _ in
                                if isShowIdCard == true {
                                    self.remainTime -= 1
                                    if remainTime == 0 {
                                        withAnimation(.spring()) {
                                            dismissIdCard()
                                        }
                                    }
                                }
                            }
                    }.frame(width: 275).padding(.top, 40)
                    Spacer()
                }.opacity(isShowIdCard ? 1 : 0)
                VStack {
                    Spacer()
                    VSpacer(500)
                    Spacer()
                    Button(action: {
                        dismissIdCard()
                    }) {
                        VStack {
                            Image("xmark").renderingMode(.template).foregroundColor(Color("gray3"))
                            Text("이곳을 눌러 닫기").notoSans(.medium, size: 11, Color("gray3"))
                        }
                        
                    }.accessibility(identifier: "button.dismissIdCard")
                    Spacer()
                }.opacity(isShowIdCard ? 1 : 0)
                
                ZStack {
                    ZStack {
                        VStack {
                            HStack {
                                Image("dimigo-logo").templateImage(height: 19, .white).padding(.leading, 25).padding(.top)
                                Spacer()
                                Image(systemName: "chevron.right").padding(.trailing, 25).foregroundColor(.white).padding(.top)
                            }
                            Spacer()
                            Text("터치하여 모바일 학생증 열기").notoSans(.bold, size: 11, .accent).padding(.vertical, 5).frame(width: horizontalSizeClass == .compact ? abs(geometry.size.width-70) : 310).opacity(0.8).background(Color.white.cornerRadius(20)).padding(.bottom)
                        }
                        .frame(width: horizontalSizeClass == .compact ? abs(geometry.size.width-40) : 335, height: 195).opacity(isShowIdCard ? 0 : 1)
                        VStack {
                            VSpacer(30)
                            WebImage(url: api.user.photoURL).resizable().placeholder(Image("user.photo.sample")).cornerRadius(5).aspectRatio(contentMode: .fit).frame(width: 116)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.15), lineWidth: 1))
                            VSpacer(20)
                            Text(api.user.name).font(Font.custom("NanumSquareEB", size: 21)).foregroundColor(.black)
                            VSpacer(20)
                            HStack(spacing: 15) {
                                VStack(alignment: .trailing, spacing: 11) {
                                    Text("학과").nanumSquare(.bold, size: 13, .black)
                                    Text("학번").nanumSquare(.bold, size: 13, .black)
                                    Text("생년월일").nanumSquare(.bold, size: 13, .black)
                                }
                                VStack(alignment: .leading, spacing: 11) {
                                    Text(getMajorByClass(class: api.user.class).localized).nanumSquare(.large, size: 13, .gray4)
                                    Text(String(api.user.serial)).nanumSquare(.large, size: 13, .gray4)
                                    Text(api.user.birthDay).nanumSquare(.large, size: 13, .gray4)
                                }
                            }
                            VSpacer(25)
                            VStack(spacing: 0) {
                                Image(uiImage: api.user.barcode).resizable().aspectRatio(contentMode: .fit).frame(height: 56)
                                Text(api.user.libraryId).notoSans(.regular, size: 9)
                            }
                            VSpacer(20)
                            Image("dimigo-logo").templateImage(height: 15, .black)
                        }.opacity(isShowIdCard ? 1 : 0)
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: -1, z: 0))
                        .scaleEffect(isShowIdCard ? 1 : 0.8)
                    }
                    .background(
                        Rectangle()
                            .foregroundColor(isShowIdCard ? .white : .accent)
                            .frame(width: !isShowIdCard ? (horizontalSizeClass == .compact ? abs(geometry.size.width-40) : 335) : 473, height: !isShowIdCard ? 195 : 275)
                            .cornerRadius(10)
                    )
                }
                .rotation3DEffect(Angle(degrees: isShowIdCard ? 180 : 0), axis: (x: 1, y: -1, z: 0))
                .onTapGesture {
                    #if targetEnvironment(simulator)
                        showIdCard()
                    #else
                        if !isShowIdCard {
                            showIdCardAfterAuthentication()
                        }
                    #endif
                }.offset(y: isShowIdCard ? 0 : -tabBarSize/2)
            }.frame(width: geometry.size.width)
        }
    }
    
    func showIdCardAfterAuthentication() {
        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            Alert.present("학생증 열기 실패", message: "학생증을 보시려면 핸드폰의 잠금을 설정시거나 앱의 접근 권한을 허용해주세요.", icon: .dangermark, color: .red)
            return
        }

        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "모바일 학생증보기", reply: { (success, _) in
                if success {
                    DispatchQueue.main.async {
                        showIdCard()
                    }
                } else {
                    DispatchQueue.main.async {
                        print("Authentication was error")
                    }
                }
            })
        } else {
            Alert.present("인증에 실패했습니다.", message: "학생증을 보시려면 생체인증을 진행하거나, 비밀번호를 입력해야 합니다.", icon: .dangermark, color: .red)
        }
    }
    func showIdCard() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        withAnimation(Animation.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)) {
            self.isShowIdCard = true
        }
        remainTime = 15
    }
    func dismissIdCard() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        withAnimation(.spring()) {
            self.isShowIdCard = false
        }
    }
}
