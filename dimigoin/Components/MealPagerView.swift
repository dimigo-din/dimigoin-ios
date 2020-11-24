//
//  MealCardView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/14.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct MealPagerView: View {
    @EnvironmentObject var mealAPI: MealAPI
    @State var currentCardIdx: Int = 0
    
    var body: some View {
        VStack {
            PagerView(pageCount: 3, currentIndex: $currentCardIdx) {
                VStack(alignment: .leading){
                    HStack {
                        Text("아침").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color("accent")).horizonPadding()
                        Spacer()
                    }
                    VSpacer(10)
                    HStack {
                        Text("\(mealAPI.getTodayMeal().breakfast)").mealMenu().horizonPadding()
                        Spacer()
                    }
                    Spacer()
                }.padding(.top)
                .modifier(CardViewModifier(305,147))
                HSpacer(15)
                VStack(alignment: .leading){
                    HStack {
                        Text("점심").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color("accent")).horizonPadding()
                        Spacer()
                    }
                    VSpacer(10)
                    HStack {
                        Text("\(mealAPI.getTodayMeal().lunch)").mealMenu().horizonPadding()
                        Spacer()
                    }
                    Spacer()
                }.padding(.top)
                .modifier(CardViewModifier(305,147))
                HSpacer(15)
                VStack(alignment: .leading){
                    HStack {
                        Text("저녁").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color("accent")).horizonPadding()
                        Spacer()
                    }
                    VSpacer(10)
                    HStack {
                        Text("\(mealAPI.getTodayMeal().dinner)").mealMenu().horizonPadding()
                        Spacer()
                    }
                    Spacer()
                }.padding(.top)
                .modifier(CardViewModifier(305,147))
            }
            VSpacer(145)
            HStack(spacing: 5){
                Circle().frame(width: 8, height: 8).foregroundColor(Color(currentCardIdx == 0 ? "accent" : "gray8"))
                Circle().frame(width: 8, height: 8).foregroundColor(Color(currentCardIdx == 1 ? "accent" : "gray8"))
                Circle().frame(width: 8, height: 8).foregroundColor(Color(currentCardIdx == 2 ? "accent" : "gray8"))
            }
        }
    }
}

struct PagerView<Content: View>: View {
    @Binding var currentIndex: Int
    @GestureState private var translation: CGFloat = 0
    @State var dragOffset = CGSize.zero
    @State var startPos = CGPoint(x: 0, y:0)
    let pageCount: Int
    let content: Content

    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            HStack {
                self.content
            }
            .offset(x: -CGFloat(self.currentIndex) * 305 + self.translation)
            .offset(x: -CGFloat((currentIndex*15)) + (UIScreen.screenWidth-305)/2)
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }.onChanged { gesture in
                    self.dragOffset = gesture.translation
                    self.startPos = gesture.location
                }
                .onEnded { gesture in
                    let xDist = abs(gesture.location.x - self.startPos.x)
                    let yDist = abs(gesture.location.y - self.startPos.y)
                    
                    if self.startPos.x > gesture.location.x && yDist < xDist {
                        // left
                        if abs(self.dragOffset.width) > 10 {
                            if currentIndex != 2 {
                                self.currentIndex += 1
                            }
                            self.dragOffset = .zero
                        } else {
                            self.dragOffset = .zero
                        }
                    }
                    else if self.startPos.x < gesture.location.x && yDist < xDist {
                        // right
                        if abs(self.dragOffset.width) > 10 {
                            if currentIndex != 0 {
                                self.currentIndex -= 1
                            }
                            self.dragOffset = .zero
                        } else {
                            self.dragOffset = .zero
                        }
                    }
                }
            )
        }
    }
}
