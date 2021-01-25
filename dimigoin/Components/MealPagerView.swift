//
//  MealCardView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/14.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import Combine
import DimigoinKit

struct MealPagerView: View {
    @EnvironmentObject var mealAPI: MealAPI
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State var dragOffset = CGSize.zero
    @State var currentCardIdx: Int = 0
    var geometry: GeometryProxy
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                VStack(alignment: .leading){
                    Text("아침").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color.accent).horizonPadding()
                    VSpacer(10)
                    Text("\(mealAPI.getTodayMeal().breakfast)").mealMenu().horizonPadding()
                }.padding(.top).modifier(CardViewModifier(305,147))
                HSpacer(15)
                VStack(alignment: .leading){
                    Text("점심").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color.accent).horizonPadding()
                    VSpacer(10)
                    Text("\(mealAPI.getTodayMeal().lunch)").mealMenu().horizonPadding()
                }.padding(.top).modifier(CardViewModifier(305,147))
                HSpacer(15)
                VStack(alignment: .leading){
                    Text("저녁").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color.accent).horizonPadding()
                    VSpacer(10)
                    Text("\(mealAPI.getTodayMeal().dinner)").mealMenu().horizonPadding()
                }.padding(.top).modifier(CardViewModifier(305,147))
            }.offset(x: (geometry.size.width-305)/2)
            .offset(x: -320*CGFloat(currentCardIdx)+dragOffset.width)
            .animation(.spring())
            .onReceive(self.timer) { _ in
                if dragOffset.width == 0 {
                    nextCard()
                }
            }
            
            .gesture(
                DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                .onChanged { value in
                    self.dragOffset = value.translation
                }
                .onEnded { value in
                    self.dragOffset = .zero
                    if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                        nextCard()
                    }
                    else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                        previousCard()
                    }
                }
            )
            HStack(spacing: 5){
                ForEach(0...2, id: \.self) { idx in
                    Circle().frame(width: 8, height: 8).foregroundColor(currentCardIdx == idx ? Color.accent : Color.divider)
                        .onTapGesture {
                            self.currentCardIdx = idx
                        }
                }
            }.offset(x: (geometry.size.width-34)/2)
        }.frame(width: geometry.size.width, alignment: .leading)
    }
    
    func nextCard() {
        if(currentCardIdx == 2) {
            withAnimation(.spring()) {
                currentCardIdx = 0
            }
        } else {
            withAnimation(.spring()) {
                self.currentCardIdx = self.currentCardIdx + 1
            }
        }
    }
    
    func previousCard() {
        if currentCardIdx != 0 {
            self.currentCardIdx -= 1
        }
    }
}



