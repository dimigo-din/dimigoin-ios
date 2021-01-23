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

struct StudentIdCardView: View {
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var userAPI: UserAPI
    @Binding var isShowIdCard: Bool
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var remainTime = 15
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    ViewTitle("학생증", sub: "모바일 학생증", icon: "idcard")
                    
                    VStack {
                        HStack {
                            Image("infomark").frame(width: 12, height: 12)
                            Text("다음 내용을 읽어주세요").font(Font.custom("NotoSansKR-Bold", size: 12)).disabled()
                        }
                        VSpacer(19)
                        Text("1. 본 증은 학교가 정식 발급한 학생증입니다.\n\n이외 신분증 등 활용은 활용처의 규정에 따라 달라질 수 있습니다.\n\n2. 본 증은 본인 이외 타인이 소지 또는 활용할 수 없습니다.\n타인에게 양도하여 입은 피해는 본인의 책임입니다.\n\n3. 스크린샷 또는 사본으로 동일한 효력을 발생시킬 수 없습니다.").disabled().multilineTextAlignment(.center).font(Font.custom("NotoSansKR-Medium", size: 11))
                            
                    }.frame(width: geometry.size.width-40)
                    .padding(.vertical)
                    .background(Color(UIColor.secondarySystemGroupedBackground).cornerRadius(10).shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0))
                    
//                    VSpacer(74)
                    
                    Spacer()
                }
                Color.black.edgesIgnoringSafeArea(.all).opacity(isShowIdCard ? 1 : 0)
                VStack {
                    HStack {
                        Image("idcard").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(width: 15).foregroundColor(Color.white)
                        Text("MOBILE ID CARD").font(Font.custom("NotoSansKR-Bold", size: 13)).foregroundColor(Color.white)
                        Spacer()
                        Text("남은 시간").font(Font.custom("NotoSansKR-Medium", size: 13)).foregroundColor(Color.white)
                        Text("\(remainTime)").font(Font.custom("NotoSansKR-Black", size: 13)).foregroundColor(Color.white)
                            .onReceive(timer) { input in
                                if(isShowIdCard == true) {
                                    self.remainTime -= 1
                                    if(remainTime == 0) {
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
                            Text("이곳을 눌러 닫기").font(Font.custom("NotoSansKR-Medium", size: 11)).foregroundColor(Color("gray3"))
                        }
                        
                    }
                    Spacer()
                }.opacity(isShowIdCard ? 1 : 0)
                ZStack {
                    ZStack{
                        VStack {
                            HStack {
                                Image("dimigo-logo").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(height: 19).foregroundColor(Color.white).padding(.leading, 25).padding(.top)
                                Spacer()
                                Image(systemName: "chevron.right").padding(.trailing, 25).foregroundColor(Color.white).padding(.top)
                            }.horizonPadding()
                            Spacer()
                            Text("터치하여 모바일 학생증 열기").font(Font.custom("NotoSansKR-Bold", size: 11)).accent().padding(.vertical, 5).frame(maxWidth: geometry.size.width - 70).opacity(0.8).background(Color.white.cornerRadius(20)).padding(.bottom)
                        }
                        .frame(height: 195).opacity(isShowIdCard ? 0 : 1)
                        VStack {
                            VSpacer(30)
                            userAPI.userPhoto.resizable().placeholder(Image("user.photo.sample")).cornerRadius(5).aspectRatio(contentMode: .fit).frame(width: 116)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.15), lineWidth: 1))
                            VSpacer(20)
                            Text(userAPI.user.name).font(Font.custom("NanumSquareEB", size: 21))
                            VSpacer(20)
                            HStack(spacing: 15) {
                                VStack(alignment: .trailing, spacing: 11){
                                    Text("학과").font(Font.custom("NanumSquareB", size: 13)).foregroundColor(Color.black)
                                    Text("학번").font(Font.custom("NanumSquareB", size: 13)).foregroundColor(Color.black)
                                    Text("주민번호").font(Font.custom("NanumSquareB", size: 13)).foregroundColor(Color.black)
                                }
                                VStack(alignment: .leading, spacing: 11) {
                                    Text(getMajor(klass: userAPI.user.klass)).font(Font.custom("NanumSquareL", size: 13)).gray4()
                                    Text(String(userAPI.user.serial)).font(Font.custom("NanumSquareL", size: 13)).gray4()
                                    Text("040101-3******").font(Font.custom("NanumSquareL", size: 13)).gray4()
                                }
                            }
                            VSpacer(25)
                            Image("qr-sample").resizable().aspectRatio(contentMode: .fit).frame(height: 47)
                            VSpacer(20)
                            Image("dimigo-logo").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(height: 28).foregroundColor(Color.black)
                        }.opacity(isShowIdCard ? 1 : 0).rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: -1, z: 0)).scaleEffect(isShowIdCard ? 1 : 0.8)
                    }
                    .background(
                        Rectangle()
                            .foregroundColor(isShowIdCard ? Color.white : Color.accent)
                            .frame(width: !isShowIdCard ? (UIDevice.current.userInterfaceIdiom == .phone ? geometry.size.width-40 : 335) : 473, height: !isShowIdCard ? 195 : 275)
//                        UIDevice.current.userInterfaceIdiom == .phone ? geometry.size.width - 20 : 380, height: 182
                            .cornerRadius(10)
                    )
                }.offset(y: isShowIdCard ? 0 : 50)
                .rotation3DEffect(Angle(degrees: isShowIdCard ? 180 : 0), axis: (x: 1, y: -1, z: 0))
                .onTapGesture {
//                    showIdCard()
                    showIdCardAfterAuthentication()
                    
                }
            }.frame(width: geometry.size.width)
            
        }
    }
    
    func showIdCardAfterAuthentication() {
        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            alertManager.createAlert("학생증 열기 실패", sub: "학생증을 보시려면 핸드폰의 잠금을 설정시거나 앱의 접근 권한을 허용해주세요.", .danger)
            return
        }

        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "모바일 학생증보기", reply: { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        showIdCard()
                    }
                }else {
                    DispatchQueue.main.async {
                        print("Authentication was error")
                    }
                }
            })
        }else {
            alertManager.createAlert("인증에 실패했습니다.", sub: "학생증을 보시려면 생체인증을 진행하거나, 비밀번호를 입력해야 합니다.", .danger)
        }
    }
    func showIdCard() {
        withAnimation(.spring()) {
            self.isShowIdCard = true
        }
        remainTime = 15
    }
    func dismissIdCard() {
        withAnimation(.spring()) {
            self.isShowIdCard = false
        }
    }
}
