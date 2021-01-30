//
//  LocationSelection.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/09.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI
import DimigoinKit
import Alamofire
import SwiftyJSON

struct LocationButton: Codable, Hashable{
    var place: Place
    var icon: String
    var idx: Int
}

struct LocationSelectionView: View {
    @EnvironmentObject var api: DimigoinAPI
    @EnvironmentObject var alertManager: AlertManager
    var locationButtons: [LocationButton] = [
    ]
    init(_ api: EnvironmentObject<DimigoinAPI>) {
        self._api = api
        locationButtons.append(LocationButton(place: self.api.findPrimaryPlaceByLabel(label: "교실"), icon: "class", idx: 0))
        locationButtons.append(LocationButton(place: self.api.findPrimaryPlaceByLabel(label: "안정실"), icon: "crossmark", idx: 1))
        locationButtons.append(LocationButton(place: self.api.findPrimaryPlaceByLabel(label: "인강실"), icon: "headphone", idx: 2))
        locationButtons.append(LocationButton(place: self.api.findPrimaryPlaceByLabel(label: "세탁"), icon: "laundry", idx: 3))
        locationButtons.append(LocationButton(place: self.api.findPrimaryPlaceByLabel(label: "동아리"), icon: "club", idx: 4))
    }
    var body: some View {
        VStack {
            SectionHeader("자습 현황", sub: getStringTimeZone()).horizonPadding()
            HStack() {
                ForEach(locationButtons, id: \.self) { location in
                    LocationItem(idx: location.idx, icon: location.icon, place: location.place)
                        .environmentObject(alertManager)
                        .environmentObject(api)
                        .accessibility(identifier: "locationSelection.\(location.icon)")
                    
                    if(locationButtons.count-1 != location.idx) {
                        Spacer()
                    }
                }
                Spacer()
                LocationItemEtc()
                    .environmentObject(alertManager)
                    .environmentObject(api)
            }.padding(.top, 5)
            .horizonPadding()
            
        }
        VSpacer(19)
    }
}

struct LocationItem: View {
    @EnvironmentObject var api: DimigoinAPI
    @EnvironmentObject var alertManager: AlertManager
    @State var idx: Int
    @State var icon: String
    var place: Place
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                api.changeUserPlace(placeName: place.name, remark: "") { result in
                    switch result {
                    case .success(_):
                        alertManager.createAlert("\(place.name)으로 장소가 바뀌었습니다.", .success)
                    case .failure(let error):
                        switch error {
                        case .noSuchPlace:
                            alertManager.createAlert("인원 점검 오류", sub: "장소 ID에러", .danger)
                        case .notRightTime:
                            alertManager.createAlert("인원 점검 오류", sub: "인원 점검 시간이 아닙니다.", .danger)
                        case .tokenExpired:
                            alertManager.createAlert("인원 점검 오류", sub: "토큰이 만료 되었습니다. 다시 시도해주세요", .danger)
                        case .unknown:
                            alertManager.createAlert("알 수 없는 에러", sub: "잠시 후 다시 시도해주세요", .danger)
                        }
                    }
                }
            }) {
                Circle()
                    .fill(api.currentPlace == place ? Color.accent : Color(UIColor.secondarySystemGroupedBackground))
                    .frame(width: 40, height: 40)
                    .shadow(color: Color.gray4.opacity(0.12), radius: 4, x: 0, y: 0)
                    .overlay(
                        Image(icon)
                            .renderingMode(.template)
                            .foregroundColor(api.currentPlace == place ? Color.white : Color.accent)
                    )
            }
            VSpacer(9)
            Text(NSLocalizedString(place.label, comment: "")).caption1()
            
        }
    }
}

struct LocationItemEtc: View {
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var api: DimigoinAPI
    
    var body: some View {
        VStack {
            Button(action: {
                alertManager.attendance()
            }) {
                Circle()
                    .fill(Color(UIColor.secondarySystemGroupedBackground))
                    .frame(width: 40, height: 40)
                    .shadow(color: Color.gray4.opacity(0.12), radius: 4, x: 0, y: 0)
                    .overlay(
                        Image("etc")
                            .renderingMode(.template)
                            .foregroundColor(Color.accent)
                    )
            }
            VSpacer(9)
            Text(NSLocalizedString("기타", comment: "")).caption1()
        }
    }
}
