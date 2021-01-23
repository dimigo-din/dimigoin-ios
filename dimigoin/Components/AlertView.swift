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
                            Text("확인")
                                .foregroundColor(Color.white)
                                .font(Font.custom("NanumSquareEB", size: 14))
                                .frame(height: 45)
                                .frame(maxWidth: .infinity)
                                .background(RoundSquare(tl: 0, tr: 0, bl: 10, br: 10).fill(alertManager.getAccentColor()))
                        }
                    }
                    
                }
                .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? geometry.size.width - 20 : 380, height: 182)
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
