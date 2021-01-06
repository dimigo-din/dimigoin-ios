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
    var name: String
    var icon: String
    var idx: Int
}



struct LocationSelectionView: View {
    @Binding var currentLocation: Int
    @EnvironmentObject var attendanceLogAPI: AttendanceLogAPI
    @EnvironmentObject var placeAPI: PlaceAPI
    @EnvironmentObject var alertManager: AlertManager
    var locationButtons: [LocationButton] = [
        LocationButton(name: "교실", icon: "class", idx: 0),
        LocationButton(name: "안정실", icon: "crossmark", idx: 1),
        LocationButton(name: "인강실", icon: "headphone", idx: 2),
        LocationButton(name: "세탁", icon: "laundry", idx: 3),
        LocationButton(name: "동아리", icon: "club", idx: 4),
        LocationButton(name: "기타", icon: "etc", idx: 5)
    ]
    var body: some View {
        VStack {
            SectionHeader("자습 현황", sub: "야간자율학습 1타임")
            HStack() {
                ForEach(locationButtons, id: \.self) { location in
                    LocationItem(currentLocation: $currentLocation, idx: location.idx, icon: location.icon, name: location.name)
                        .environmentObject(attendanceLogAPI)
                        .environmentObject(placeAPI)
                        .environmentObject(alertManager)
                    if(locationButtons.count-1 != location.idx) {
                        Spacer()
                    }
                }
            }.padding(.top, 5)
            .horizonPadding()
            
        }
        VSpacer(19)
        HDivider()
    }
}

struct LocationItem: View {
    @EnvironmentObject var attendanceLogAPI: AttendanceLogAPI
    @EnvironmentObject var placeAPI: PlaceAPI
    @EnvironmentObject var alertManager: AlertManager
    @Binding var currentLocation: Int
    @State var idx: Int
    @State var icon: String
    @State var name: String
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.currentLocation = idx
                LOG("set user location")
                let headers: HTTPHeaders = [
                    "Authorization":"Bearer \(placeAPI.tokenAPI.accessToken)"
                ]
                let parameters: [String: String] = [
                    "place": placeAPI.getMatchedPlace(name: name).id,
                    "remark": "remark"
                ]
                let url = "http://edison.dimigo.hs.kr/attendance-log"
                AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).response { response in
                    if let status = response.response?.statusCode {
                        switch(status) {
                        case 200:
                            alertManager.createAlert("자습 위치 변경 : \(name)", sub: "자습위치가 성공적으로 바뀌었습니다.", .success)
                            LOG("set user location to \(name)")
                        case 423:
                            alertManager.createAlert("자습 현황 변경 실패", sub: "출입인증을 할 수 있는 시간이 아닙니다.", .danger)
                            LOG("출입인증을 할 수 있는 시간이 아님")
                        default:
                            if debugMode {
                                debugPrint(response)
                            }
                            self.placeAPI.tokenAPI.refreshTokens()
                            attendanceLogAPI.setMyLocation(place: placeAPI.getMatchedPlace(name: name))
                        }
                    }
                }
            }) {
                Circle()
                    .fill(currentLocation == idx ? Color("accent") : Color.white)
                    .frame(width: 40, height: 40)
                    .shadow(color: Color("gray4").opacity(0.12), radius: 4, x: 0, y: 0)
                    .overlay(
                        Image(currentLocation == idx ? "\(icon)-white" : "\(icon)")
                    )
            }
            VSpacer(9)
            Text(NSLocalizedString(name, comment: "")).caption1()
            
        }
    }
}
