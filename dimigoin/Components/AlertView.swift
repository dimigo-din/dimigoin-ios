//
//  AlertView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/09.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import Combine
import DimigoinKit

struct AlertView: View {
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var tokenAPI: TokenAPI
    @Binding var isShowing: Bool
    @State var dragOffset = CGSize.zero
    @State var startPos = CGPoint(x: 0, y: 0)
    
    var body: some View {
        ZStack {
            if isShowing {
                BlurView().edgesIgnoringSafeArea(.all).onTapGesture {
                    dismiss()
                }
            }
            GeometryReader { geometry in
                VStack(spacing: 0){
                    if alertManager.alertType == .text {
                        VSpacer(35)
                        Text(alertManager.content).foregroundColor(Color.text)
                            .font(Font.custom("NotoSansKR-Bold", size: 14))
                        VSpacer(20)
                        Text(alertManager.sub).alertSubTitle().multilineTextAlignment(.center)
                        
                    }
                    else if alertManager.alertType == .idCardReadme {
                        VStack {
                            HStack {
                                Image("infomark").frame(width: 12, height: 12)
                                Text("다음 내용을 읽어주세요").font(Font.custom("NotoSansKR-Bold", size: 12)).disabled()
                            }
                            VSpacer(19)
                            Text("1. 본 증은 학교가 정식 발급한 학생증입니다.\n\n이외 신분증 등 활용은 활용처의 규정에 따라 달라질 수 있습니다.\n\n2. 본 증은 본인 이외 타인이 소지 또는 활용할 수 없습니다.\n타인에게 양도하여 입은 피해는 본인의 책임입니다.\n\n3. 스크린샷 또는 사본으로 동일한 효력을 발생시킬 수 없습니다.").disabled().multilineTextAlignment(.center).font(Font.custom("NotoSansKR-Medium", size: 11))
                        }
                        .padding(.vertical)
                                            
                    }
                    else {
                        VSpacer(35)
                        Image(alertManager.getIconName()).renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(width: 30).foregroundColor(alertManager.getAccentColor())
                        VSpacer(23)
                        Text(alertManager.content).alertTitle(alertManager.getTitleColor()).foregroundColor(alertManager.getTitleColor())
                    }
                    
                    Spacer()
                    if alertManager.alertType == .logout {
                        HStack(spacing: 0){
                            Button(action: {
                                dismiss()
                            }) {
                                Text("취소")
                                    .foregroundColor(Color.white)
                                    .font(Font.custom("NanumSquareEB", size: 14))
                                    .frame(height: 45)
                                    .frame(maxWidth: .infinity)
                                    .background(RoundSquare(tl: 0, tr: 0, bl: 10, br: 0).fill(Color.gray4))
                            }
                            Button(action: {
                                dismiss()
                                tokenAPI.clearTokens()
                            }) {
                                Text("확인")
                                    .foregroundColor(Color.white)
                                    .font(Font.custom("NanumSquareEB", size: 14))
                                    .frame(height: 45)
                                    .frame(maxWidth: .infinity)
                                    .background(RoundSquare(tl: 0, tr: 0, bl: 0, br: 10).fill(alertManager.getAccentColor()))
                            }
                        }
                        
                    }
                    else {
                        Button(action: {
                            dismiss()
                        }) {
                            Text(alertManager.alertType == .idCardReadme ? "닫기":"확인")
                                .foregroundColor(Color.white)
                                .font(Font.custom("NanumSquareEB", size: 14))
                                .frame(height: 45)
                                .frame(maxWidth: .infinity)
                                .background(RoundSquare(tl: 0, tr: 0, bl: 10, br: 10).fill(alertManager.getAccentColor()))
                        }
                    }
                    
                }
                .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? geometry.size.width - 20 : 380, height: alertManager.alertType == .idCardReadme ? 260 : 195)
                .background(Color(UIColor.systemBackground).cornerRadius(10))
                .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .phone ? 10 : (geometry.size.width - 380)/2)
                .padding(.top, (geometry.size.height - 182)/2)
                .edgesIgnoringSafeArea(.all)
            }.frame(alignment: .center)
        }
        .opacity(isShowing ? 1 : 0)
    }
    
    
    
    func dismiss() {
        withAnimation(.spring()) {
            self.isShowing = false
        }
    }
}

struct BlurView: UIViewRepresentable {
    var effect: UIVisualEffect = UIBlurEffect(style: .systemThinMaterial)
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
