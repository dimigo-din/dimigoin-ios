//
//  Alert.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/09.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation
import DimigoinKit
import SwiftUI

public enum Alert {
    public static func present(_ title: String, icon: AlertView.AlertIcon, color: Color) {
        AlertViewController(alertView: AlertView(icon: icon, color: color, message: title)).present()
    }
    
    public static func present(_ title: String, message: String, icon: AlertView.AlertIcon, color: Color) {
        AlertViewController(alertView: AlertView(content: {
            AnyView(
                VStack {
                    VSpacer(40)
                    Image(icon.rawValue).templateImage(width: 30, color)
                    VSpacer(15)
                    Text(title).notoSans(.bold, size: 15, .gray4)
                    Text(message).notoSans(.medium, size: 12, .gray4).padding(.bottom, 25)
                }
            )
        },
        centerButton: AlertView.Button.center("확인", color: color)
        )).present()
    }
    
    public static func attendanceHistory(attendance: Attendance, attendanceLog: [AttendanceLog]) {
        AlertViewController(alertView: AlertView(content: {
            AnyView(
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        ZStack {
                            VStack {
                                VSpacer(35)
                                Text("\(attendance.grade)학년 \(attendance.class)반 \(attendance.number)번")
                                    .notoSans(.bold, size: 10, .accent)
                                VSpacer(4)
                                Text("\(attendance.name)")
                                    .notoSans(.bold, size: 20, .text)
                                VSpacer(14)
                                HStack {
                                    VStack {
                                        Text("현재위치")
                                            .notoSans(.medium, size: 12, .gray4)
                                        VSpacer(7)
                                        if attendance.isRegistered {
                                            PlaceBadge(place: attendance.attendanceLog[0].place)
                                        } else {
                                            PlaceBadge(placeName: "\(attendance.grade)학년 \(attendance.class)반", placeType: .classroom)
                                        }
                                    }
                                    HSpacer(64)
                                    VStack {
                                        Text("등록시간")
                                            .notoSans(.medium, size: 12, .gray4)
                                        VSpacer(7)
                                        if attendance.isRegistered {
                                            Text(attendance.attendanceLog[0].time)
                                                .notoSans(.medium, size: 10, .gray4)
                                                .frame(width: 60, height: 20)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .stroke(Color("gray6"), lineWidth: 1)
                                                )
                                        } else {
                                            Text("미등록")
                                                .notoSans(.medium, size: 10, .gray4)
                                                .frame(width: 60, height: 20)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .stroke(Color("gray6"), lineWidth: 1)
                                                )
                                        }
                                    }
                                }
                                VSpacer(30)
                                HDivider()
                                ScrollView {
                                    VStack(spacing: 15) {
                                        ForEach(0..<attendanceLog.count, id: \.self) { idx in
                                            Text("[ \(attendanceLog[idx].time) ] \(attendance.name)님이 자신의 현황을 ")
                                                .notoSans(.medium, size: 10, .gray4)
                                            +
                                            Text(attendanceLog[idx].place.name)
                                            .notoSans(.bold, size: 10, .accent)
                                            +
                                            Text("(으)로 \(idx == 0 ? "등록" : "변경")")
                                                .notoSans(.medium, size: 10, .gray4)
                                        }
                                    }.multilineTextAlignment(.leading)
                                    .padding(.horizontal, 10)
                                    VSpacer(15)
                                }
                                .padding(.bottom, 45)
                            }
                        }
                    }
                    .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? abs(geometry.size.width - 80) : 295)
                    .background(Color(UIColor.systemBackground).cornerRadius(10))
                    .edgesIgnoringSafeArea(.all)
                    .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .phone ? 40 : (geometry.size.width - 295)/2)
                }.frame(maxHeight: 450, alignment: .center)

            )
        },
        centerButton: AlertView.Button.center("확인", color: .accent)
        )).present()
    }
    
    public static func classHistory(grade: Int, `class`: Int, attendanceLog: [AttendanceLog]) {
        AlertViewController(alertView: AlertView(content: {
            AnyView(
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        ZStack {
                            VStack {
                                VSpacer(35)
                                Text("\(grade)학년 \(`class`)반")
                                    .notoSans(.bold, size: 10, .accent)
                                VSpacer(4)
                                Text("히스토리")
                                    .notoSans(.bold, size: 20, .text)
                                VSpacer(15)
                                ScrollView {
                                    VStack(spacing: 15) {
                                        ForEach(0..<attendanceLog.count, id: \.self) { idx in
                                            Text("[ \(attendanceLog[idx].time) ] \(attendanceLog[idx].student.name)님이 자신의 현황을 ")
                                                .notoSans(.medium, size: 10, .gray4)
                                            +
                                            Text(attendanceLog[idx].place.name)
                                                .notoSans(.bold, size: 10, .accent)
                                            +
                                            Text("(으)로 변경")
                                                .notoSans(.medium, size: 10, .gray4)
                                        }
                                    }.multilineTextAlignment(.leading)
                                    .padding(.horizontal, 10)
                                    VSpacer(15)
                                }
                                .padding(.bottom, 45)
                            }
                        }
                    }
                    .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? abs(geometry.size.width - 80) : 295)
                    .background(Color(UIColor.systemBackground).cornerRadius(10))
                    .edgesIgnoringSafeArea(.all)
                    .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .phone ? 40 : (geometry.size.width - 295)/2)
                }.frame(maxHeight: 450, alignment: .center)
            )
        },
        centerButton: AlertView.Button.center("확인", color: .accent)
        )).present()
    }
    
    public static func changeLocation(api: DimigoinAPI) {
        AlertViewController(alertView: AlertView(content: {
            AnyView(
                ChangeLocationDialog().environmentObject(api)
            )
        }
        )).present()
    }
    
    public static func changeLocation(api: DimigoinAPI, student: Attendance) {
        AlertViewController(alertView: AlertView(content: {
            AnyView(
                ChangeLocationDialog(student: student).environmentObject(api)
            )
        }
        )).present()
    }
    
    public static func updateRequired() {
        AlertViewController(alertView: AlertView(content: {
            AnyView(
                VStack {
                    VSpacer(40)
                    Image("warningmark").templateImage(width: 30, .yellow)
                    VSpacer(15)
                    Text("최신버전으로 업데이트 해주세요!").notoSans(.bold, size: 15, .gray4)
                    Text("확인을 누르면 앱스토어로 이동합니다").notoSans(.medium, size: 13, .gray4).padding(.bottom, 25)
                }
            )
        },
        leadingButton: AlertView.Button.dismiss(),
        trailingButton: AlertView.Button(label: "확인", color: .yellow, position: .trailing, action: {
            if let url = URL(string: "https://apps.apple.com/app/id1548069749") {
                UIApplication.shared.open(url, options: [:])
            }
        })
        )).present()
    }
    
    public static func forgetPassword() {
        AlertViewController(alertView: AlertView(content: {
            AnyView(
                VStack {
                    VSpacer(35)
                    Text("아이디 또는 패스워드를 잊으셨나요?")
                        .notoSans(.bold, size: 14)
                    VSpacer(18)
                    Text("계정을 분실하셨다면 본관 1층 교무실\nIT 특성화부 하미영 선생님께 문의 하시기 바랍니다")
                        .notoSans(.medium, size: 12, .gray4)
                    VSpacer(26)
                }.multilineTextAlignment(.center)
            )
        },
        centerButton: AlertView.Button.center("확인", color: .accent)
        )).present()
    }
    
    public static func readmeBeforeUseIDCard() {
        AlertViewController(alertView: AlertView(content: {
            AnyView(
                VStack {
                    VSpacer(30)
                    HStack {
                        Image("infomark").templateImage(width: 14, height: 14, .gray4)
                        Text("사용 전 다음 내용을 반드시 읽어주세요").notoSans(.bold, size: 12, .gray4)
                    }
                    VSpacer(24)
                    Text("1. 본 증은 학교가 정식 발급한 학생증입니다.\n이외 신분증 등 활용은 활용처의 규정에 따라 달라질 수 있습니다.\n\n2. 본 증은 본인 이외 타인이 소지 또는 활용할 수 없습니다.\n타인에게 양도하여 입은 피해는 본인의 책임입니다.\n\n3. 스크린샷 또는 사본으로 동일한 효력을 발생시킬 수 없습니다.")
                        .notoSans(.medium, size: 11, Color("gray6"))
                        .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                    VSpacer(23)
                }
            )
        },
        centerButton: AlertView.Button.center("닫기", color: .gray4)
        )).present()
    }
    
    public static func logoutCheck(api: DimigoinAPI) {
        AlertViewController(alertView: AlertView(content: {
            AnyView(
                VStack {
                    VSpacer(48)
                    Image("logout").templateImage(width: 20, .accent)
                    VSpacer(20)
                    Text("정말 로그아웃 하시겠습니까?").notoSans(.bold, size: 15, .text).padding(.bottom, 40)
                }
            )
        },
        leadingButton: AlertView.Button.dismiss(),
        trailingButton: AlertView.Button(label: "확인", color: .accent, position: .trailing, action: {
            api.logout()
        }))).present()
    }
}

struct ChangeLocationDialog: View {
    @EnvironmentObject var api: DimigoinAPI
    @State var selectedPlace: Place = Place()
    @State var remark: String = ""
    @State var isShowPlaceList: Bool = false
    @State var isRemarkEmpty: Bool = false
    var student: Attendance = Attendance()
    
    init() {
        self.student = Attendance()
    }
    
    init(student: Attendance) {
        self.student = student
    }
   
    var body: some View {
        NavigationView {
                VStack {
                VSpacer(20)
                Text("\(getStringTimeZone())").notoSans(.bold, size: 11, .accent)
                Text("어디에 계신가요?").notoSans(.bold, size: 16)
                VSpacer(20)
                VStack {
                    NavigationLink(destination: SelectPlaceView(api: api, selectedPlace: $selectedPlace), isActive: $isShowPlaceList) {
                        HStack {
                            Text(selectedPlace == Place() ? "장소를 선택하세요" : selectedPlace.name)
                                .foregroundColor(.accent)
                                .font(Font.custom("NanumSquareR", size: 14))
                                .padding(.leading)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .padding(.trailing)
                                .foregroundColor(.accent)
                        }
                    }
                    .frame(width: 335, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("divider"), lineWidth: 1)
                    )
                    VSpacer(15)
                    TextField("사유를 입력하세요", text: $remark).textContentType(.none)
                        .modifier(TextFieldModifier(isError: $isRemarkEmpty))
                        .modifier(ClearButton(text: $remark))
                    if isRemarkEmpty {
                        Text("사유는 비어 있을 수 없습니다")
                            .notoSans(.medium, size: 12, .red)
                    }
                    
                    Text("사전 허가된 활동 또는 감독 교사 승인 외\n임의로 등록할 경우 불이익을 받을 수 있습니다.")
                        .notoSans(.medium, size: 12, Color("gray7")).multilineTextAlignment(.center)
                        .padding(.top, 20)
                }
                Spacer()
                HStack(spacing: 0) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("취소")
                            .foregroundColor(.white)
                            .notoSans(.bold, size: 14)
                            .frame(height: 45)
                            .frame(maxWidth: .infinity)
                            .background(RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 10, bottomRight: 0).fill(Color.gray4))
                    }
                    Button(action: {
//                        if remark.isEmpty {
//                            withAnimation(.easeInOut) { self.isRemarkEmpty = true }
//                        } else {
                            dismiss()
                            if student == Attendance() {
                                api.changeUserPlace(placeName: selectedPlace.name, remark: remark.isEmpty ? "없음" : remark) { result in
                                    switch result {
                                    case .success(_):
                                        Alert.present("위치 변경에 성공했습니다.", message: "\"\(selectedPlace.name)\"(으)로 변경되었습니다.", icon: .checkmark, color: .accent)
                                    case .failure(let error):
                                        switch error {
                                        case .noSuchPlace:
                                            Alert.present("위치 변경에 실패했습니다.", message: "유효한 장소가 아닙니다.", icon: .dangermark, color: .red)
                                        case .notRightTime:
                                            Alert.present("위치 변경에 실패했습니다.", message: "자습 현황 등록 시간이 아닙니다.", icon: .dangermark, color: .red)
                                        case .tokenExpired:
                                            Alert.present("위치 변경에 실패했습니다.", message: "토큰이 만료 되었습니다.", icon: .dangermark, color: .red)
                                        case .unknown:
                                            Alert.present("위치 변경에 실패했습니다.", message: "알 수 없는 에러", icon: .dangermark, color: .red)
                                        }
                                    }
                                }
                            } else {
                                setUserPlace(api.accessToken, studentId: student.id, placeName: selectedPlace.name, remark: remark.isEmpty ? "없음" : remark, places: api.allPlaces) { result in
                                    switch result {
                                    case .success(_):
                                        Alert.present("위치 변경에 성공했습니다.", message: "\"\(selectedPlace.name)\"(으)로 변경되었습니다.", icon: .checkmark, color: .accent)
                                    case .failure(let error):
                                        switch error {
                                        case .noSuchPlace:
                                            Alert.present("위치 변경에 실패했습니다.", message: "유효한 장소가 아닙니다.", icon: .dangermark, color: .red)
                                        case .notRightTime:
                                            Alert.present("위치 변경에 실패했습니다.", message: "자습 현황 등록 시간이 아닙니다.", icon: .dangermark, color: .red)
                                        case .tokenExpired:
                                            Alert.present("위치 변경에 실패했습니다.", message: "토큰이 만료 되었습니다.", icon: .dangermark, color: .red)
                                        case .unknown:
                                            Alert.present("위치 변경에 실패했습니다.", message: "알 수 없는 에러", icon: .dangermark, color: .red)
                                        }
                                    }
                                }
                            }
                            
//                        }
                    }) {
                        Text("확인")
                            .foregroundColor(.white)
                            .notoSans(.bold, size: 14)
                            .frame(height: 45)
                            .frame(maxWidth: .infinity)
                            .background(RoundSquare(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 10).fill(Color.accent))
                    }
                }
            }
            .navigationBarHidden(true)
        }.frame(height: isShowPlaceList ? 480 : 320, alignment: .center)
        .navigationViewStyle(StackNavigationViewStyle())
        .cornerRadius(10)
        .animation(.easeInOut)
    }
    
    func dismiss() {
        UIApplication.shared.windows.first!.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
