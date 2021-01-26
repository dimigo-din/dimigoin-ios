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
    @EnvironmentObject var api: DimigoinAPI
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
            SectionHeader("자습 현황", sub: "야간자율학습 1타임").horizonPadding()
            HStack() {
                ForEach(locationButtons, id: \.self) { location in
                    LocationItem(currentLocation: $currentLocation, idx: location.idx, icon: location.icon, name: location.name)
                        .environmentObject(alertManager)
                        .environmentObject(api)
                        .accessibility(identifier: "locationSelection.\(location.icon)")
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
    @EnvironmentObject var api: DimigoinAPI
    @EnvironmentObject var alertManager: AlertManager
    @Binding var currentLocation: Int
    @State var idx: Int
    @State var icon: String
    @State var name: String
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                // set user location
            }) {
                Circle()
                    .fill(currentLocation == idx ? Color.accent : Color(UIColor.secondarySystemGroupedBackground))
                    .frame(width: 40, height: 40)
                    .shadow(color: Color.gray4.opacity(0.12), radius: 4, x: 0, y: 0)
                    .overlay(
                        Image(icon)
                            .renderingMode(.template)
                            .foregroundColor(currentLocation == idx ? Color.white : Color.accent)
                    )
            }
            VSpacer(9)
            Text(NSLocalizedString(name, comment: "")).caption1()
            
        }
    }
}
