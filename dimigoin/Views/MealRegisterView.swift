//
//  MealRegisterView.swift
//  dimigoin
//
//  Created by 변경민 on 2021/03/05.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct MealRegisterView: View {
    @EnvironmentObject var api: DimigoinAPI
    @EnvironmentObject var alertManager: AlertManager
    
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false

    @State private var date = Date()
    @State var meal = Meal()
    @State private var isFetching: Bool = false
    @State var breakfastImage: UIImage?
    @State var lunchImage: UIImage?
    @State var dinnerImage: UIImage?

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
                                    if meal.breakfast.isEmpty && meal.lunch.isEmpty && meal.dinner.isEmpty {
                                        Text("미리보기")
                                            .notoSans(.bold, size: 12, Color.white)
                                            .frame(width: 74, height: 25)
                                            .background(Color.accent.cornerRadius(13))
                                            .opacity(0.5)
                                    } else {
                                        NavigationLink(destination:
                                            MealPreviewView(meal)
                                                
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
                        MealInput(mealName: "아침", menus: $meal.breakfast, selectedImage: $meal.breakfastImage, sourceType: $sourceType, isImagePickerDisplay: $isImagePickerDisplay)
                        MealInput(mealName: "점심", menus: $meal.lunch, selectedImage: $meal.lunchImage, sourceType: $sourceType, isImagePickerDisplay: $isImagePickerDisplay)
                        MealInput(mealName: "저녁", menus: $meal.dinner, selectedImage: $meal.dinnerImage, sourceType: $sourceType, isImagePickerDisplay: $isImagePickerDisplay)
                        VSpacer(8)
                        if isFetching {
                            HStack {
                                Image(systemName: "trash")
                                    .foregroundColor(Color.white)
                                    .frame(width: 50, height: 50)
                                    .background(Color.gray4.cornerRadius(10))
                                HSpacer(10)
                                ProgressView()
                                    .foregroundColor(Color.white)
                                    .frame(width: abs(geometry.size.width-40-60), height: 50)
                                    .background(Color.accent.cornerRadius(10))
                            }
                        } else {
                            HStack {
                                Button(action: {
                                    withAnimation(.easeInOut) {
                                        self.meal = Meal()
                                    }
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(Color.white)
                                        .frame(width: 50, height: 50)
                                        .background(Color.gray4.cornerRadius(10))
                                }
                                HSpacer(10)
                                Button(action: {
                                    withAnimation(.easeInOut) { self.isFetching = true }
                                    registerMeal(accessToken: api.accessToken,
                                                 date: date,
                                                 meal: meal) { result in
                                        switch result {
                                        case .success():
                                            alertManager.createAlert("\(getDateString(from: date)) 급식 등록에 성공하였습니다.", .success)
                                            withAnimation(.easeInOut) { self.isFetching = false }
                                        case .failure(let error):
                                            switch error {
                                            case .alreadyExist:
                                                patchMeal(accessToken: api.accessToken,
                                                          date: date,
                                                          meal: meal) {
                                                    
                                                    self.alertManager.createAlert("\(getDateString(from: date)) 급식 수정에 성공하였습니다.", .success)
                                                    withAnimation(.easeInOut) { self.isFetching = false }
                                                }
                                            default:
                                                alertManager.createAlert("오류가 발생하였습니다.", .danger)
                                                withAnimation(.easeInOut) { self.isFetching = false }
                                            }
                                        }
                                        api.fetchMealData()
                                    }
                                }) {
                                    Text("\(getDateString(from: date)) 급식 등록하기")
                                        .nanumSquare(.extraBold, size: 14, Color.white)
                                        .foregroundColor(Color.white)
                                        .frame(width: abs(geometry.size.width-40-60), height: 50)
                                        .background(Color.accent.cornerRadius(10))
                                }
                            }
                        }
                    }
                    .onChange(of: date) { _ in
                        getMeal(from: date) { meal in
                            withAnimation(.easeInOut) { self.meal = meal }
                        }
                    }
                    .onAppear {
                        getMeal(from: date) { meal in
                            withAnimation(.easeInOut) { self.meal = meal }
                        }
                    }
                }
                
                Color.black.edgesIgnoringSafeArea(.all).opacity(alertManager.isShowing ? 0.1 : 0)
                AlertView()
                    .environmentObject(api)
                    .environmentObject(alertManager)
                    .ignoresSafeArea(.all)
                
            }
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePicker(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
            .navigationBarTitle("", displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MealInput: View {
    @State var mealName: String
    @Binding var menus: [String]
    @Binding var selectedImage: UIImage?
    @Binding var sourceType: UIImagePickerController.SourceType
    @Binding var isImagePickerDisplay: Bool

    var body: some View {
        VStack {
            TagField(tags: $menus, placeholder: "급식을 입력해주세요")
                .accentColor(Color.accent)
                .horizonPadding()
            HStack {
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                } else {
                    Text("사진을 선택해주세요")
                        .nanumSquare(.regular, size: 14, Color.gray4)
                        .padding(.leading)
                }
                Spacer()
                HStack(spacing: 5) {
                    Button(action: {
                        self.sourceType = .camera
                        self.isImagePickerDisplay.toggle()
                    }) {
                        Image(systemName: "camera")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Color.white)
                            .frame(width: 35, height: 35)
                            .background(Color.accent.cornerRadius(15))
                    }
                    Button(action: {
                        self.sourceType = .photoLibrary
                        self.isImagePickerDisplay.toggle()
                    }) {
                        Image(systemName: "photo")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(Color.white)
                            .frame(width: 35, height: 35)
                            .background(Color.accent.cornerRadius(15))
                    }
                }
//                VStack(spacing: 5) {
//                    Button(action: {
//                        self.sourceType = .camera
//                    }) {
//                        HStack {
//                            Image(systemName: "camera")
//                                .font(.system(size: 12, weight: .semibold))
//                                .foregroundColor(Color.white)
//                            Text("사진찍기")
//                                .notoSans(.bold, size: 12, Color.white)
//
//                        }.frame(width: 90, height: 25)
//                        .background(Color.accent.cornerRadius(13))
//                    }
//                    Button(action: {
//                        self.sourceType = .photoLibrary
//                        self.isImagePickerDisplay.toggle()
//                    }) {
//                        HStack {
//                            Image(systemName: "photo")
//                                .font(.system(size: 12, weight: .semibold))
//                                .foregroundColor(Color.white)
//                            Text("앨범열기")
//                                .notoSans(.bold, size: 12, Color.white)
//
//                        }.frame(width: 90, height: 25)
//                        .background(Color.accent.cornerRadius(13))
//                    }
//                }
            }.horizonPadding()
        }
        
    }
}
