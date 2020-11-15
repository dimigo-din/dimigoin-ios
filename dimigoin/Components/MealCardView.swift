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
    @ObservedObject var mealAPI: MealAPI
    @Binding var currentCardIdx: Int
    var body: some View {
        VStack {
            PagerView(pageCount: 3, currentIndex: $currentCardIdx) {
                VStack(alignment: .leading){
                    Text("아침").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color("Accent")).horizonPadding()
                    VSpacer(10)
                    Text("\(mealAPI.getTodayMeal().breakfast)").mealMenu().horizonPadding()
                }.modifier(CardViewModifier(305,147))
                VStack(alignment: .leading) {
                    Text("점심").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color("Accent")).horizonPadding()
                    VSpacer(10)
                    Text("\(mealAPI.getTodayMeal().lunch)").mealMenu().horizonPadding()
                }.modifier(CardViewModifier(305,147))
                VStack(alignment: .leading) {
                    Text("저녁").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color("Accent")).horizonPadding()
                    VSpacer(10)
                    Text("\(mealAPI.getTodayMeal().dinner)").mealMenu().horizonPadding()
                }.modifier(CardViewModifier(305,147))
            }
            VSpacer(145)
            HStack(spacing: 5){
                Circle().frame(width: 8, height: 8).foregroundColor(Color(currentCardIdx == 0 ? "Accent" : "Gray8"))
                Circle().frame(width: 8, height: 8).foregroundColor(Color(currentCardIdx == 1 ? "Accent" : "Gray8"))
                Circle().frame(width: 8, height: 8).foregroundColor(Color(currentCardIdx == 2 ? "Accent" : "Gray8"))
            }
        }
    }
}

struct PagerView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content

    @GestureState private var translation: CGFloat = 0

    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                self.content.frame(width: geometry.size.width*0.85)
            }
            .frame(width: geometry.size.width*0.85, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * (geometry.size.width*0.85))
            .offset(x: self.translation)
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
                    let offset = value.translation.width / (geometry.size.width*0.85)
                    let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                    self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                }
            )
            .padding(.leading, geometry.size.width*0.075)
        }
    }
}
