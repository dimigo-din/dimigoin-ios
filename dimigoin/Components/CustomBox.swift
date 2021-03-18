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
    var accentColor: Color = .accent
    var width: CGFloat = 5
    var topLeft: CGFloat = 2
    var topRight: CGFloat = 17
    var bottomLeft: CGFloat = 2
    var bottomRight: CGFloat = 17

    var body: some View {
        GeometryReader { geometry in
            Path { path in

                let width = geometry.size.width
                let height = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let topRight = min(min(self.topRight, height/2), width/2)
                let topLeft = min(min(self.topLeft, height/2), width/2)
                let bottomLeft = min(min(self.bottomLeft, height/2), width/2)
                let bottomRight = min(min(self.bottomRight, height/2), width/2)

                path.move(to: CGPoint(x: width / 2.0, y: 0))
                path.addLine(to: CGPoint(x: width - topRight, y: 0))
                path.addArc(center: CGPoint(x: width - topRight, y: topRight), radius: topRight, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: width, y: height - bottomRight))
                path.addArc(center: CGPoint(x: width - bottomRight, y: height - bottomRight), radius: bottomRight, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bottomLeft, y: height))
                path.addArc(center: CGPoint(x: bottomLeft, y: height - bottomLeft), radius: bottomLeft, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: topLeft))
                path.addArc(center: CGPoint(x: topLeft, y: topLeft), radius: topLeft, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
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
        
        if edgeInsets == [.leading] {
            topRight -= 2
            topLeft = 0
            bottomRight -= 2
            bottomLeft = 0
        } else if edgeInsets == [.top] {
            topRight = 0
            topLeft = 0
            bottomRight -= 2
            bottomLeft -= 2
        } else if edgeInsets == [.trailing] {
            topRight = 0
            topLeft -= 2
            bottomRight = 0
            bottomLeft -= 2
        } else if edgeInsets == [.bottom] {
            topRight -= 2
            topLeft -= 2
            bottomRight = 0
            bottomLeft = 0
        }
        
        return RoundSquare(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight).fill(Color(UIColor.secondarySystemGroupedBackground)).padding(edgeInsets, width)
    }
}

struct RoundSquare: Shape {
    var topLeft: CGFloat = 0.0
    var topRight: CGFloat = 0.0
    var bottomLeft: CGFloat = 0.0
    var bottomRight: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.size.width
        let height = rect.size.height

        // Make sure we do not exceed the size of the rectangle
        let topRight = min(min(self.topRight, height/2), width/2)
        let topLeft = min(min(self.topLeft, height/2), width/2)
        let bottomLeft = min(min(self.bottomLeft, height/2), width/2)
        let bottomRight = min(min(self.bottomRight, height/2), width/2)

        path.move(to: CGPoint(x: width / 2.0, y: 0))
        path.addLine(to: CGPoint(x: width - topRight, y: 0))
        path.addArc(center: CGPoint(x: width - topRight, y: topRight), radius: topRight,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        path.addLine(to: CGPoint(x: width, y: height - bottomRight))
        path.addArc(center: CGPoint(x: width - bottomRight, y: height - bottomRight), radius: bottomRight,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: bottomLeft, y: height))
        path.addArc(center: CGPoint(x: bottomLeft, y: height - bottomLeft), radius: bottomLeft,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: topLeft))
        path.addArc(center: CGPoint(x: topLeft, y: topLeft), radius: topLeft,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        return path
    }
}
