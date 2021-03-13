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
//    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var api: DimigoinAPI
    @State var showLogoutButton: Bool = false
    @Binding var tapbarIndex: Int
    @Namespace var homeview
    
    var body: some View {
//        if !api.isFetching {
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                VStack {
                    ZStack {
                        VStack {
                            VSpacer(50)
                            Image("school").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: .infinity).opacity(0.3).unredacted()
                        }
                        HStack {
                            Image("logo").templateImage(height: 38, Color.accent)
                                .matchedGeometryEffect(id: "logo", in: homeview)
                                .unredacted()
                            Spacer()
                            Button(action: {
//                                alertManager.logoutCheck()
                            }) {
                                Image("logout").templateImage(width: 30, Color.accent)
                            }.offset(x: showLogoutButton ? 0 : 45)
                            
                            ZStack {
                                Circle().fill(Color.systemBackground).frame(width: 38, height: 38)
                                withAnimation {
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
                                        .unredacted()
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
//                        .environmentObject(alertManager)
                    NoticeItem(geometry: geometry)
                        .environmentObject(api)
                    VSpacer(calMidSpace(geo: geometry))
                    MealPagerView(geometry: geometry)
                        .environmentObject(api)
                    VSpacer(tabBarSize + 40)
                }.frame(width: geometry.size.width)
            }
            }
//        } else {
//            ZStack {
//                Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)
//                Image("logo").templateImage(width: 73, Color.accent)
//                    .matchedGeometryEffect(id: "logo", in: homeview)
//                    .offset(y: -50)
//            }
//        }
    }
    func calMidSpace(geo: GeometryProxy) -> CGFloat {
        var space = geo.size.height-tabBarSize-420-(14*geo.size.width/75)
        if api.notices.count != 0 {
            space -= 180
        }
        if space <= 0 {
            return 20
        } else {
            return space
        }
    }
}
