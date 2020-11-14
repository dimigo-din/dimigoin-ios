//
//  StudentIdCardModalView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/14.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct StudentIdCardModalView: View {
    @Binding var isShowing: Bool
    @ObservedObject var userAPI: UserAPI
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.isShowing.toggle()
                }) {
                    Image(systemName: "xmark").resizable().aspectRatio(contentMode: .fit).frame(width: 16)
                        .foregroundColor(Color("Gray1")).padding()
                }
            }
            Image("userPhoto-sample").resizable().aspectRatio(contentMode: .fit).frame(width: 131)
            // MARK: replace userPhoto-sample to userImage when backend ready
            Text(userAPI.user.name).font(Font.custom("NotoSansKR-Bold", size: 25))
            VSpacer(14)
            HStack {
                VStack(alignment: .leading, spacing: 8){
                    Text("학과").infoText().gray6()
                    Text("학번").infoText().gray6()
                    Text("주민번호").infoText().gray6()
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text(getMajor(klass: userAPI.user.klass)).infoText()
                    Text(userAPI.user.serial).infoText()
                    Text("030418-3******").infoText()
                }
            }
            VSpacer(15)
            Text("위 사람은 본교 학생임을 증명함.").font(Font.custom("NotoSansKR-Bold", size: 14))
            Image("dimigo-logo").resizable().aspectRatio(contentMode: .fit).frame(width: 263)
            Image("qr-sample").resizable().aspectRatio(contentMode: .fit).frame(width: 239)
            Spacer()
        }
        .frame(width: 300,height: 560)
        .background(
            CustomBox(edgeInsets: .bottom, accentColor: Color("Accent"), width: 13, tl: 10, tr: 10, bl: 10, br: 10)
        )
        .offset(y: isShowing ? 0 : 800)
        .animation(.spring())
    }
}
