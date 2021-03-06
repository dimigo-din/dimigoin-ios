//
//  MealRegisterView.swift
//  dimigoin
//
//  Created by 변경민 on 2021/03/05.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit
import TagField

struct MealRegisterView: View {
    @EnvironmentObject var api: DimigoinAPI
    @State private var date = Date()
    @State var breakfast: [String] = []
    @State var lunch: [String] = []
    @State var dinner: [String] = []
    
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = UIColor(Color.accent)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geometry in
                    ScrollView {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("디미고인").notoSans(.bold, size: 13, Color.gray4)
                                HStack {
                                    Text("급식 등록").notoSans(.black, size: 30)
                                    Button(action: {
                                        api.logout()
                                    }) {
                                        Image("logout").templateImage(width: 25, Color.accent)
                                    }
                                    Spacer()
                                    if breakfast.isEmpty && lunch.isEmpty && dinner.isEmpty {
                                        Text("미리보기")
                                            .notoSans(.bold, size: 12, Color.white)
                                            .frame(width: 74, height: 25)
                                            .background(Color.accent.cornerRadius(13))
                                            .opacity(0.5)
                                    } else {
                                        NavigationLink(destination:
                                            MealPreviewView(breakfast, lunch, dinner)
                                                
                                        ) {
                                            Text("미리보기")
                                                .notoSans(.bold, size: 12, Color.white)
                                                .frame(width: 74, height: 25)
                                                .background(Color.accent.cornerRadius(13))
                                        }
                                    }
                                    NavigationLink(destination:
                                        MealView().environmentObject(api)
                                    ) {
                                        Text("급식보기")
                                            .notoSans(.bold, size: 12, Color.white)
                                            .frame(width: 74, height: 25)
                                            .background(Color.accent.cornerRadius(13))
                                    }
                                }
                            }
                        }.horizonPadding()
                        HStack {
                            Text("날짜를 선택해주세요")
                                .nanumSquare(.regular, size: 14, Color.gray4)
                                .padding(.leading)
                            Spacer()
                            DatePicker("등록 날짜를 선택해주세요", selection: $date, displayedComponents: .date)
                                .accentColor(Color.accent)
                                .labelsHidden()
                        }.horizonPadding()
                        VSpacer(8)
                        TagField(tags: $breakfast, placeholder: "아침 급식을 입력해주세요")
                            .accentColor(Color.accent)
                            .horizonPadding()
                        TagField(tags: $lunch, placeholder: "점심 급식을 입력해주세요")
                            .accentColor(Color.accent)
                            .horizonPadding()
                        TagField(tags: $dinner, placeholder: "저녁 급식을 입력해주세요")
                            .accentColor(Color.accent)
                            .horizonPadding()
                        Button(action: {
                            
                        }) {
                            Text("\(getDateString(from: date)) 급식 등록하기")
                                .nanumSquare(.extraBold, size: 14, Color.white)
//                                .notoSans(.bold, size: 18)
                                .foregroundColor(Color.white)
                                .frame(width: abs(geometry.size.width-40), height: 50)
                                .background(Color.accent.cornerRadius(10))
                        }
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}
