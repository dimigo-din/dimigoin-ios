//
//  CustomBox.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/14.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct CustomBox: View {
    var edgeInsets: Edge.Set = [.leading]
    var accentColor: Color = Color("Accent")
    var width: CGFloat = 5
    var tl: CGFloat = 2
    var tr: CGFloat = 17
    var bl: CGFloat = 2
    var br: CGFloat = 17

    var body: some View {
        GeometryReader { geometry in
            Path { path in

                let w = geometry.size.width
                let h = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)

                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .overlay(
                getForegroundSquare(edgeInsets: edgeInsets)
            )
            .foregroundColor(accentColor)
            .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 0)
        }
    }
    func getForegroundSquare(edgeInsets: Edge.Set) -> some View {
        var topRight: CGFloat = 0
        var topLeft: CGFloat = 0
        var bottomRight: CGFloat = 0
        var bottomLeft: CGFloat = 0
        
        if(edgeInsets == [.leading]) {
            topRight = tr-2
            topLeft = 0
            bottomRight = br-2
            bottomLeft = 0
        }
        else if(edgeInsets == [.top]) {
            topRight = 0
            topLeft = 0
            bottomRight = br-2
            bottomLeft = bl-2
        }
        else if(edgeInsets == [.trailing]) {
            topRight = 0
            topLeft = tl-2
            bottomRight = 0
            bottomLeft = bl-2
        }
        else if(edgeInsets == [.bottom]) {
            topRight = tr-2
            topLeft = tl-2
            bottomRight = 0
            bottomLeft = 0
        }
        
        return RoundSquare(tl: topLeft, tr: topRight, bl: bottomLeft, br: bottomRight).fill(Color.white).padding(edgeInsets, width)
    }
}

struct RoundSquare: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.size.width
        let h = rect.size.height

        // Make sure we do not exceed the size of the rectangle
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)

        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        return path
    }
}
