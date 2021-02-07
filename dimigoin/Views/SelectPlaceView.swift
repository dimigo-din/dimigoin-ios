//
//  SelectLocationView.swift
//  dimigoin
//
//  Created by 변경민 on 2021/01/30.
//  Copyright © 2021 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit

struct SelectPlaceView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var api: DimigoinAPI
    @Binding var selectedPlace: Place
    
    init(api: DimigoinAPI, selectedPlace: Binding<Place>) {
        self._api = .init(initialValue: api)
        self._selectedPlace = selectedPlace
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
                ScrollView {
                    Text("야간자율학습 학생현황").notoSans(.bold, size: 12, Color.accent)
                    Text("장소를 선택해주세요").notoSans(.bold, size: 20)
                    PlaceList(api: api, selectedPlace: $selectedPlace)
                }
//                VStack {
//                    Spacer()
//                    VStack {
//                        Spacer()
//                        Button(action: {
//                            self.presentationMode.wrappedValue.dismiss()
//                        }) {
//                            Text("선택완료")
//                                .notoSans(.bold, size: 14)
//                                .foregroundColor(Color.white)
//                                .frame(width: geometry.size.width-40, height: 50)
//                                .background(Color("accent").cornerRadius(10))
//                        }
//                        Spacer()
//                    }.frame(height: 100)
//                    .frame(maxWidth: .infinity)
//                    .background(Rectangle().fill(Color.systemBackground).shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 0).edgesIgnoringSafeArea(.all))
//                    .edgesIgnoringSafeArea(.all)
//
//                }
//            }
//        }
    }
}

struct PlaceList: View {
    @State var api: DimigoinAPI
    @Binding var selectedPlace: Place

    var body: some View {
        VStack(spacing: 0) {
            HDivider()
            ForEach(api.allPlaces, id: \.self) { place in
                PlaceListItem(place: place, selectedPlace: $selectedPlace)
            }
            VSpacer(100)
        }
    }
}

struct PlaceListItem: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var place: Place
    @Binding var selectedPlace: Place
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .strokeBorder(Color.gray, lineWidth: 1)
                    .frame(width: 26, height: 26)
                Circle()
                    .strokeBorder(Color.accent, lineWidth: selectedPlace.id == place.id ? 15 : 0)
                    .frame(width: 26, height: 26)
                Circle()
                    .fill(Color(UIColor.secondarySystemGroupedBackground))
                    .frame(width: 12, height: 12)
            }.animation(.easeInOut(duration: 0.25))
            .padding(.leading, 25)
            HSpacer(25)
            Text("\(place.name)")
                .notoSans(selectedPlace.id == place.id ? .bold: .medium,
                          size: 16,
                          selectedPlace.id == place.id ? Color.text : Color.gray4)
                .padding(.trailing, 25)
            Spacer()
        }.frame(height: 50)
        .contentShape(Rectangle())
        .background(Color.accent.opacity(selectedPlace.id == place.id ? 0.05 : 0))
        .onTapGesture {
            withAnimation(.spring()) {
                self.selectedPlace = place
            }
            self.presentationMode.wrappedValue.dismiss()
        }
        HDivider()
    }
}
