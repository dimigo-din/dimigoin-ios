//
//  HomeView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit
import LocalAuthentication
import SDWebImageSwiftUI

struct HomeView: View {
    @EnvironmentObject var mealAPI: MealAPI
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var tokenAPI : TokenAPI
    @EnvironmentObject var userAPI: UserAPI
    @Binding var isShowIdCard: Bool
    @State var currentLocation = 0
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false){
                VStack{
                    ZStack {
                        VStack {
                            if UIDevice.current.userInterfaceIdiom == .phone {
                                VSpacer(70)
                            } else {
                                VSpacer(20)
                            }
                            Image("school").resizable().aspectRatio(contentMode: .fit).frame(width: geometry.size.width).opacity(0.3)
                        }
                        HStack {
                            Image("logo").resizable().aspectRatio(contentMode: .fit).frame(height: 38)
                            Spacer()
                            Button(action: {
                                showIdCard()
                                
                            }) {
                                // MARK: replace userPhoto-sample to userImage when backend ready
                                withAnimation() {
                                    userAPI.userPhoto
                                        .resizable()
                                        .placeholder(Image(systemName: "person.crop.circle"))
                                        .foregroundColor(Color("accent"))
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 38)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle().stroke(Color("accent"), lineWidth: 2)
                                        )
                                }
                            }
                        }.horizonPadding()
                    }
                    VSpacer(15)
                    LocationSelectionView(currentLocation: $currentLocation)
                    Spacer()
                    Text("오늘의 급식").font(Font.custom("NotoSansKR-Bold", size: 20)).horizonPadding()
                    MealPagerView()
                        .environmentObject(mealAPI)
                }
            }
        }
    }
    func showIdCardAfterAuthentication() {
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "학생증 보기") { (status, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            } else {
               showIdCard()
            }
            
        }
    }
    func showIdCard() {
        withAnimation(.spring()) {
            self.isShowIdCard = true
        }
    }
    func dismissIdCard() {
        withAnimation(.spring()) {
            self.isShowIdCard = false
        }
    }
}


