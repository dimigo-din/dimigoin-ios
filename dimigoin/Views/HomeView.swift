//
//  HomeView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit
import SDWebImageSwiftUI

struct HomeView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var api: DimigoinAPI
    @State var showLogoutButton: Bool = false
    
    @Binding var tapbarIndex: Int 
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack {
                    ZStack {
                        VStack {
                            VSpacer(50)
                            if(horizontalSizeClass == .compact) {
                                Image("school").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: .infinity).opacity(0.3)
                            }
                            else {
                                Image("school").resizable().frame(maxWidth: .infinity).opacity(0.3)
                            }
                        }
                        HStack {
                            Image("logo").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(height: 38).foregroundColor(Color.accent)
                            Spacer()
                            Button(action: {
                                alertManager.logoutCheck()
                            }) {
                                Image("logout").renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(width: 30).foregroundColor(Color.accent)
                            }.offset(x: showLogoutButton ? 0 : 45)
                            
                            ZStack {
                                Circle().fill(Color.systemBackground).frame(width: 38, height: 38)
                                withAnimation() {
                                    WebImage(url: api.user.photoURL)
                                        .resizable()
                                        .foregroundColor(Color.accent)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 38)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle().stroke(Color.accent, lineWidth: 2)
                                        )
                                        .accessibility(identifier: "profile")
                                }
                            }.onTapGesture {
                                withAnimation(.spring()) {
                                    self.showLogoutButton.toggle()
                                }
                            }
                            
                        }.horizonPadding()
                    }.frame(width: geometry.size.width)
                    VSpacer(15)
                    LocationSelectionView(_api)
                        .environmentObject(alertManager)
                    MealPagerView(geometry: geometry)
                        .environmentObject(api)
                    VSpacer(tabBarSize + 40)
                }.frame(width: geometry.size.width)
            }
        }
    }
}
