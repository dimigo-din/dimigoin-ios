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
    @State var startPos = CGPoint(x: 0, y:0)
    @GestureState private var translation: CGFloat = 0
    @State var currentCardIdx: Int = 0
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack {
                    VStack(alignment: .leading){
                        Text("아침").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color("accent")).horizonPadding()
                        VSpacer(10)
                        Text("\(mealAPI.getTodayMeal().breakfast)").mealMenu().horizonPadding()
                    }.padding(.top).modifier(CardViewModifier(305,147))
                    HSpacer(15)
                    VStack(alignment: .leading){
                        Text("점심").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color("accent")).horizonPadding()
                        VSpacer(10)
                        Text("\(mealAPI.getTodayMeal().lunch)").mealMenu().horizonPadding()
                    }.padding(.top).modifier(CardViewModifier(305,147))
                    HSpacer(15)
                    VStack(alignment: .leading){
                        Text("저녁").font(Font.custom("NotoSansKR-Bold", size: 18)).foregroundColor(Color("accent")).horizonPadding()
                        VSpacer(10)
                        Text("\(mealAPI.getTodayMeal().dinner)").mealMenu().horizonPadding()
                    }.padding(.top).modifier(CardViewModifier(305,147))
                }
                .offset(x: -CGFloat(self.currentCardIdx) * 305 + self.translation)
                .offset(x: -CGFloat((self.currentCardIdx*15)) + (geometry.size.width-305)/2)
                .animation(.spring())
                .onReceive(self.timer) { _ in
                    nextCard()
                }
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
                                self.nextCard()
                                self.dragOffset = .zero
                            } else {
                                self.dragOffset = .zero
                            }
                        }
                        else if self.startPos.x < gesture.location.x && yDist < xDist {
                            // right
                            if abs(self.dragOffset.width) > 10 {
                                self.previousCard()
                                self.dragOffset = .zero
                            } else {
                                self.dragOffset = .zero
                            }
                        }
                    }
                )
                
            }
            VSpacer(145)
            HStack(spacing: 5){
                ForEach(0...2, id: \.self) { idx in
                    Circle().frame(width: 8, height: 8).foregroundColor(Color(currentCardIdx == idx ? "accent" : "divider"))
                        .onTapGesture {
                            self.currentCardIdx = idx
                        }
                }
            }
        }
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



