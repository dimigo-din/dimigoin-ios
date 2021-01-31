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
    
    init(api: DimigoinAPI) {
        self._api = .init(initialValue: api)
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        ScrollView {
            Text("야간자율학습 학생현황").font(Font.custom("NotoSansKR-Bold", size: 12)).accent()
            Text("장소를 선택해주세요").font(Font.custom("NotoSansKR-Bold", size: 20))
            PlaceList(api: api)
        }
    }
}

struct PlaceList: View {
    @State var api: DimigoinAPI

    var body: some View {
        ForEach(api.allPlaces, id: \.self) { place in
            PlaceListItem(place: place)
        }
    }
}

struct PlaceListItem: View {
    @State var place: Place
    var body: some View {
        Text("\(place.name)")
    }
}

