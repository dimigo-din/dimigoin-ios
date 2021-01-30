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
    @EnvironmentObject var api: DimigoinAPI
    @State var dragOffset = CGSize.zero
    @State var startPos = CGPoint(x: 0, y: 0)
    @State var placeName: String = ""
    @State var remark: String = ""
    
    var body: some View {
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
                    idcardReadme
                }
                else if alertManager.alertType == .attendance {
                    VSpacer(20)
                    Text("\(getCurrentTimeString())").font(Font.custom("NotoSansKR-Bold", size: 11)).accent()
                    Text("어디에 계신가요?").font(Font.custom("NotoSansKR-Bold", size: 16))
                    VSpacer(20)
                    TextField("장소를 입력하세요", text: $placeName).textContentType(.none)
                        .modifier(TextFieldModifier())
                        .modifier(ClearButton(text: $placeName))
                    VSpacer(15)
                    TextField("사유를 입력하세요", text: $remark).textContentType(.none)
                        .modifier(TextFieldModifier())
                        .modifier(ClearButton(text: $remark))
                    VSpacer(20)
                    Text("사전 허가된 활동 또는 감독 교사 승인 외\n임의로 등록할 경우 불이익을 받을 수 있습니다.").font(Font.custom("NotoSansKR-Medium", size: 12)).foregroundColor(Color("gray7")).multilineTextAlignment(.center)
                }
                else {
                    VStack {
                        VSpacer(35)
                        Image(alertManager.getIconName()).renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(width: 30).foregroundColor(alertManager.getAccentColor())
                        VSpacer(23)
                        Text(alertManager.content).alertTitle(alertManager.getTitleColor()).foregroundColor(alertManager.getTitleColor())
                        VSpacer(5)
                        if(alertManager.sub != "") {
                            Text(alertManager.sub).alertSubTitle().foregroundColor(Color.gray4.opacity(0.7))
                        }
                    }.animation(.none)
                }
                Spacer()
                if alertManager.alertType == .logout {
                    logoutButtons
                }
                else if alertManager.alertType == .attendance {
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
                            api.changeUserPlace(placeName: placeName, remark: remark) { result in
                                switch result {
                                case .success(_):
                                    self.alertManager.createAlert("\(placeName)으로 위치가 변경되었습니다.", .danger)
                                case .failure(let error):
                                    switch error {
                                    case .noSuchPlace:
                                        self.alertManager.createAlert("출입 인증에 실패 하였습니다.", sub: "동일한 장소 이름을 찾지 못했습니다.", .danger)
                                    case .notRightTime:
                                        self.alertManager.createAlert("출입 인증에 실패 하였습니다.", sub: "출입 인증을 할 수 있는 시간이 아닙니다.", .danger)
                                    case .tokenExpired:
                                        self.alertManager.createAlert("출입 인증에 실패 하였습니다.", sub: "토큰이 만료 되었습니다.", .danger)
                                    case .unknown:
                                        self.alertManager.createAlert("알 수 없는 에러", sub: "나중에 다시 시도해 주세요.", .danger)
                                    }
                                }
                                
                            }
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
                        Text(alertManager.alertType == .idCardReadme ? "닫기" : "확인")
                            .foregroundColor(Color.white)
                            .font(Font.custom("NanumSquareEB", size: 14))
                            .frame(height: 45)
                            .frame(maxWidth: .infinity)
                            .background(RoundSquare(tl: 0, tr: 0, bl: 10, br: 10).fill(alertManager.getAccentColor()))
                    }
                }
                
            }
            .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? geometry.size.width - 20 : 380, height: alertManager.alertType == .idCardReadme ? 260 : (alertManager.alertType == .attendance ? 314 : 195))
            .background(Color(UIColor.systemBackground).cornerRadius(10).animation(.none))
            .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .phone ? 10 : (geometry.size.width - 380)/2)
            .padding(.top, (geometry.size.height - (alertManager.alertType == .idCardReadme ? 260 : (alertManager.alertType == .attendance ? 314 : 195)))/2)
            .edgesIgnoringSafeArea(.all)
        }.frame(alignment: .center)
        .opacity(alertManager.isShowing ? 1 : 0)
    }
    
    func dismiss() {
        withAnimation(.spring()) {
            alertManager.isShowing = false
        }
    }
    
    var idcardReadme: some View {
        return VStack {
            HStack {
                Image("infomark").frame(width: 12, height: 12)
                Text("다음 내용을 읽어주세요").font(Font.custom("NotoSansKR-Bold", size: 12)).disabled()
            }
            VSpacer(19)
            Text("1. 본 증은 학교가 정식 발급한 학생증입니다.\n\n이외 신분증 등 활용은 활용처의 규정에 따라 달라질 수 있습니다.\n\n2. 본 증은 본인 이외 타인이 소지 또는 활용할 수 없습니다.\n타인에게 양도하여 입은 피해는 본인의 책임입니다.\n\n3. 스크린샷 또는 사본으로 동일한 효력을 발생시킬 수 없습니다.").disabled().multilineTextAlignment(.center).font(Font.custom("NotoSansKR-Medium", size: 11))
        }.animation(.none)
        .padding(.vertical)
    }
    
    var logoutButtons: some View {
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
                api.logout()
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
}
