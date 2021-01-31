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
    @State var api: DimigoinAPI
    @Binding var selectedPlace: Place
    
    init(api: DimigoinAPI, selectedPlace: Binding<Place>) {
        self._api = .init(initialValue: api)
        self._selectedPlace = selectedPlace
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        ScrollView {
            Text("야간자율학습 학생현황").font(Font.custom("NotoSansKR-Bold", size: 12)).accent()
            Text("장소를 선택해주세요").font(Font.custom("NotoSansKR-Bold", size: 20))
            PlaceList(api: api, selectedPlace: $selectedPlace)
        }
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
                    .frame(width: 20, height: 20)
                Circle()
                    .fill(Color.accent)
                    .frame(width: selectedPlace.id == place.id ? 12 : 0, height: selectedPlace.id == place.id ? 12 : 0)
            }.padding(.leading)
            Spacer()
            Text("\(place.name)").font(Font.custom("NotoSansKR-Medium", size: 14)).padding(.trailing)
        }.frame(height: 50)
        .contentShape(Rectangle())
        .background(Color.accent.opacity(selectedPlace.id == place.id ? 0.05 : 0))
        .onTapGesture {
            withAnimation() {
                self.selectedPlace = place
            }
            
            self.presentationMode.wrappedValue.dismiss()
        }
        HDivider()
    }
}

