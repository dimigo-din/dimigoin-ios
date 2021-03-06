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
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false

    @EnvironmentObject var api: DimigoinAPI
    @State private var date = Date()
    @State var breakfast: [String] = []
    @State var lunch: [String] = []
    @State var dinner: [String] = []
    @State var isShowImagePreview: Bool = false
    @Namespace var mealRegisterView

    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = UIColor(Color.accent)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if isShowImagePreview {
                    GeometryReader { geometry in
                        Color.black.ignoresSafeArea(.all)
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width)
                            .onTapGesture {
                                withAnimation(.spring()) { isShowImagePreview.toggle() }
                            }
                            .matchedGeometryEffect(id: "mealImage", in: mealRegisterView)
                            
                        Button(action: {
                            withAnimation(.spring()) { isShowImagePreview.toggle() }
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(Color.white)
                                .frame(alignment: .topLeading)
                                .ignoresSafeArea(.all)
                                .padding()
                        }
                    }
                } else {
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
                            HStack {
                                if selectedImage != nil {
                                    Image(uiImage: selectedImage!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                        .onTapGesture {
                                            withAnimation(.spring()) { isShowImagePreview.toggle() }
                                        }
                                        .matchedGeometryEffect(id: "mealImage", in: mealRegisterView)
                                } else {
                                    Text("사진을 선택해주세요")
                                        .nanumSquare(.regular, size: 14, Color.gray4)
                                        .padding(.leading)
                                }
                                Spacer()
                                VStack(spacing: 5) {
                                    Button(action: {
                                        self.sourceType = .camera
                                        self.isImagePickerDisplay.toggle()
                                    }) {
                                        HStack {
                                            Image(systemName: "camera")
                                                .font(.system(size: 12, weight: .semibold))
                                                .foregroundColor(Color.white)
                                            Text("사진찍기")
                                                .notoSans(.bold, size: 12, Color.white)
                                                
                                        }.frame(width: 90, height: 25)
                                        .background(Color.accent.cornerRadius(13))
                                    }
                                    Button(action: {
                                        self.sourceType = .photoLibrary
                                        self.isImagePickerDisplay.toggle()
                                    }) {
                                        HStack {
                                            Image(systemName: "photo")
                                                .font(.system(size: 12, weight: .semibold))
                                                .foregroundColor(Color.white)
                                            Text("앨범열기")
                                                .notoSans(.bold, size: 12, Color.white)
                                                
                                        }.frame(width: 90, height: 25)
                                        .background(Color.accent.cornerRadius(13))
                                    }
                                }
                            }.horizonPadding()
                            VSpacer(8)
                            Button(action: {
                                registerMeal(accessToken: api.accessToken,
                                             date: date,
                                             meal: Meal(breakfast, lunch, dinner)) { result in
                                    switch result {
                                    case .success(): break
                                    case .failure(let error):
                                        switch error {
                                        case .alreadyExist:
                                            patchMeal(accessToken: api.accessToken,
                                                      date: date,
                                                      meal: Meal(breakfast, lunch, dinner)) { }
                                        default:
                                            print("error")
                                        }
                                    }
                                }
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
                
            }
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePicker(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}
