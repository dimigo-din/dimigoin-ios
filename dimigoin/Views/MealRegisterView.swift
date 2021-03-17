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
//    @EnvironmentObject var alertManager: AlertManager
    @State private var date = Date()
    @State private var meal = Meal()
    @State private var isFetching: Bool = false

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
                        MealInput(mealName: "아침", menus: $meal.breakfast, selectedImage: $meal.breakfastImage)
                        MealInput(mealName: "점심", menus: $meal.lunch, selectedImage: $meal.lunchImage)
                        MealInput(mealName: "저녁", menus: $meal.dinner, selectedImage: $meal.dinnerImage)
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
                                            Alert.present("\(getDateString(from: date)) 급식 등록에 성공하였습니다.", icon: .checkmark, color: .accent)
                                            withAnimation(.easeInOut) { self.isFetching = false }
                                        case .failure(let error):
                                            switch error {
                                            case .alreadyExist:
                                                patchMeal(accessToken: api.accessToken,
                                                          date: date,
                                                          meal: meal) {
                                                    
                                                    Alert.present("\(getDateString(from: date)) 급식 수정에 성공하였습니다.", icon: .checkmark, color: .accent)
                                                    withAnimation(.easeInOut) { self.isFetching = false }
                                                }
                                            default:
//                                                alertManager.createAlert("오류가 발생하였습니다.", .danger)
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
                    .padding(.bottom, 20)
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
            }
            .navigationBarTitle("", displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MealInput: View {
    @State var mealName: String
    @Binding var menus: [String]
    @Binding var selectedImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var showImagePicker: Bool = false

    var body: some View {
        VStack {
            TagField(tags: $menus, placeholder: "\(mealName) 급식을 입력해주세요")
                .accentColor(Color.accent)
                .horizonPadding()
            HStack {
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                        .cornerRadius(5)
                } else {
                    Text("사진을 선택해주세요")
                        .nanumSquare(.regular, size: 14, Color.gray4)
                        .padding(.leading)
                }
                Spacer()
                HStack(spacing: 5) {
                    Button(action: {
                        self.sourceType = .camera
                        self.showImagePicker.toggle()
                    }) {
                        Image(systemName: "camera")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Color.white)
                            .frame(width: 35, height: 35)
                            .background(Color.accent.cornerRadius(15))
                    }
                    Button(action: {
                        self.sourceType = .photoLibrary
                        self.showImagePicker.toggle()
                    }) {
                        Image(systemName: "photo")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(Color.white)
                            .frame(width: 35, height: 35)
                            .background(Color.accent.cornerRadius(15))
                    }
                }
            }.horizonPadding()
        }
        .sheet(isPresented: self.$showImagePicker) {
            ImagePicker(selectedImage: self.$selectedImage, sourceType: self.sourceType)
        }
    }
}
