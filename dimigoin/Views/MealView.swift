//
//  MealView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/08.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct MealView: View {
    @EnvironmentObject var api: DimigoinAPI
    @State var selectedDay: Int = getTodayDayOfWeekInt()-1
    private let days: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    @State var dragOffset = CGSize.zero

    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(getDateString()).notoSans(.bold, size: 13, Color.gray4)
                                Text("오늘의 급식").notoSans(.black, size: 30)
                            }
                            Spacer()
                            NavigationLink(destination: WeeklyMealView().environmentObject(api)) {
                                Image("meal").templateImage(height: 35, Color.accent)
                            }
                        }
                        .horizonPadding()
                        .padding(.top, 30)
                        VSpacer(20)
                        HStack(spacing: 0) {
                            ForEach(0 ..< days.count) { index in
                                Button(action: {
                                    withAnimation {
                                        self.selectedDay = index
                                    }
                                }) {
                                    Text(self.days[index])
                                        .notoSans(.bold, size: 17)
                                        .foregroundColor(index == selectedDay ? Color.accent : Color.gray4)
                                        .frame(width: abs(geometry.size.width-40)/7)
                                        
                                }
                            }
                        }.frame(width: abs(geometry.size.width-40))
                        ZStack(alignment: .leading) {
                            HDivider()
                            Rectangle()
                                .fill(Color("accent"))
                                .frame(width: abs(geometry.size.width-40)/7, height: 2)
                                .cornerRadius(2)
                                .offset(x: dayIndicatorXOffset(geometry: geometry))
                                
                        }.frame(width: abs(geometry.size.width-40))
                    }.frame(width: geometry.size.width)
                    VSpacer(20)
                    HStack(spacing: 0) {
                        ForEach(0..<7, id: \.self) { index in
                            VStack {
                                SectionHeader("아침", sub: "오전 7시 30분")
                                Text(api.meals[index].breakfast)
                                    .notoSans(.regular, size: 12, Color("gray2"))
                                    .padding()
                                    .frame(width: abs(geometry.size.width-40), alignment: .leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .background(Color(UIColor.secondarySystemGroupedBackground).cornerRadius(10).shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0))
                                VSpacer(30)
                                SectionHeader("점심", sub: "오후 12시 50분")
                                Text(api.meals[index].lunch)
                                    .notoSans(.regular, size: 12, Color("gray2"))
                                    .padding()
                                    .frame(width: abs(geometry.size.width-40), alignment: .leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .background(Color(UIColor.secondarySystemGroupedBackground).cornerRadius(10).shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0))
                                VSpacer(30)
                                SectionHeader("저녁", sub: "오후 6시 35분")
                                Text(api.meals[index].dinner)
                                    .notoSans(.regular, size: 12, Color("gray2"))
                                    .padding()
                                    .frame(width: abs(geometry.size.width-40), alignment: .leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .background(Color(UIColor.secondarySystemGroupedBackground).cornerRadius(10).shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0))
                            }
                            .horizonPadding()
                            .frame(width: geometry.size.width)
                        }
                    }.offset(x: -geometry.size.width*CGFloat(selectedDay-3)+dragOffset.width)
                    .animation(.spring())
                    .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                        .onChanged { value in
                            withAnimation(.spring()) {
                                self.dragOffset = value.translation
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                self.dragOffset = .zero
                            }
                            if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                                nextMeal()
                            } else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                                previousMeal()
                            }
                        }
                    )
                    .contentShape(Rectangle())
                }.frame(width: geometry.size.width)
                VSpacer(100)
            }
        }
    }
    func nextMeal() {
        if selectedDay != 6 {
            withAnimation(.spring()) {
                self.selectedDay += 1
            }
           
       }
    }
    
    func previousMeal() {
        if selectedDay != 0 {
            withAnimation(.spring()) {
                self.selectedDay -= 1
            }
           
       }
    }
    
    func dayIndicatorXOffset(geometry: GeometryProxy) -> CGFloat {
        return CGFloat(selectedDay)*(geometry.size.width-40)/7 - dragOffset.width*(geometry.size.width-40)/7/geometry.size.width
    }
}
