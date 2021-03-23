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

struct LocationButton: Hashable {
    var place: Place
    var icon: String
    var idx: Int
}

struct LocationSelectionView: View {
    @EnvironmentObject var api: DimigoinAPI

    var locationButtons: [LocationButton] = [
    ]
    init(_ api: EnvironmentObject<DimigoinAPI>) {
        self._api = api
        locationButtons.append(LocationButton(place: self.api.findPrimaryPlaceByLabel(label: "교실"), icon: "class", idx: 0))
        locationButtons.append(LocationButton(place: self.api.findPrimaryPlaceByLabel(label: "안정실"), icon: "crossmark", idx: 1))
        locationButtons.append(LocationButton(place: self.api.findPrimaryPlaceByLabel(label: "인강실"), icon: "headphone", idx: 2))
        locationButtons.append(LocationButton(place: self.api.findPrimaryPlaceByLabel(label: "세탁"), icon: "laundry", idx: 3))
//        locationButtons.append(LocationButton(place: self.api.findPrimaryPlaceByLabel(label: "동아리"), icon: "club", idx: 4))
    }
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(getStringTimeZone().localized).notoSans(.bold, size: 10, .accent)
                    Spacer()
                }
                HStack {
                    Text(NSLocalizedString("자습 현황", comment: "")).notoSans(.bold, size: 21)
                    Spacer()
                    NavigationLink(destination:
                        AttendanceListView()
                            .environmentObject(api)
                    ) {
                        Text("자세히")
                            .notoSans(.bold, size: 12, .white)
                            .frame(width: 74, height: 25)
                            .background(Color.accent.cornerRadius(15))
                    }
                }
            }.horizonPadding()
            HStack {
                ForEach(locationButtons, id: \.self) { location in
                    LocationItem(idx: location.idx, icon: location.icon, place: location.place)
                        .environmentObject(api)
                        .accessibility(identifier: "locationSelection.\(location.icon)")
                    if locationButtons.count-1 != location.idx {
                        Spacer()
                    }
                }
                Spacer()
                LocationItemEtc()
                    .environmentObject(api)
            }.padding(.top, 5)
            .horizonPadding()
        }
        VSpacer(19)
    }
}

struct LocationItem: View {
    @EnvironmentObject var api: DimigoinAPI
    @State var idx: Int
    @State var icon: String
    var place: Place
    @State var isFetching: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.easeInOut) { self.isFetching = true }
                api.changeUserPlace(placeName: place.name, remark: "없음") { result in
                    switch result {
                    case .success(()):
                        self.api.fetchUserCurrentPlace {
                            self.api.fetchAttendanceListData {
                                Alert.present("위치 변경에 성공했습니다.", message: "\"\(place.name)\"(으)로 변경되었습니다.", icon: .checkmark, color: .accent)
                                withAnimation(.easeInOut) { self.isFetching = false }
                            }
                        }
                    case .failure(let error):
                        switch error {
                        case .noSuchPlace:
                            Alert.present("위치 변경에 실패했습니다.", message: "유효하지 않은 장소입니다.", icon: .dangermark, color: .red)
                        case .notRightTime:
                            Alert.present("위치 변경에 실패했습니다.", message: "인원 점검 시간이 아닙니다.", icon: .dangermark, color: .red)
                        case .tokenExpired:
                            Alert.present("위치 변경에 실패했습니다.", message: "토큰이 만료 되었습니다. 다시 시도해주세요", icon: .dangermark, color: .red)
                        case .unknown:
                            Alert.present("알 수 없는 에러", message: "잠시 후 다시 시도해주세요", icon: .dangermark, color: .red)
                        }
                        withAnimation(.easeInOut) { self.isFetching = false }
                    }
                }
            }) {
                Circle()
                    .fill(api.currentPlace.id == place.id ? .accent : Color(UIColor.secondarySystemGroupedBackground))
                    .frame(width: 40, height: 40)
                    .shadow(color: Color.gray4.opacity(0.12), radius: 4, x: 0, y: 0)
                    .overlay(
                        ZStack {
                            if self.isFetching {
                                ProgressView()
                            } else {
                                Image(icon)
                                    .renderingMode(.template)
                                    .foregroundColor(api.currentPlace.id == place.id ? .white : .accent)
                            }
                        }
                        
                    )
            }
            VSpacer(9)
            Text(NSLocalizedString(place.label, comment: "")).notoSans(.medium, size: 12)
            
        }
    }
}

struct LocationItemEtc: View {
    @EnvironmentObject var api: DimigoinAPI
    @State var isFetching: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                Alert.changeLocation(api: api)
            }) {
                Circle()
                    .fill(!api.isPrimaryPlace(place: api.currentPlace) ? .accent : Color(UIColor.secondarySystemGroupedBackground))
                    .frame(width: 40, height: 40)
                    .shadow(color: Color.gray4.opacity(0.12), radius: 4, x: 0, y: 0)
                    .overlay(
                        ZStack {
                            if self.isFetching {
                                ProgressView()
                            } else {
                                Image("etc")
                                    .renderingMode(.template)
                                    .foregroundColor(!api.isPrimaryPlace(place: api.currentPlace) ? .white : .accent)
                            }
                        }
                    )
            }
            VSpacer(9)
            Text(NSLocalizedString("기타", comment: "")).notoSans(.medium, size: 12)
        }
    }
}
