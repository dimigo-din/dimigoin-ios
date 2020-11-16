//
//  Carousel.swift
//  dimigoin
//
//  Created by 변경민 on 2020/11/11.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

fileprivate class CarouselConfig: ObservableObject {
  @Published var cardWidth: CGFloat = 0
  @Published var cardCount: Int = 0
  @Published var selected: Int = 0
}

struct Carousel<Cards: View>: View {
  let cards: Cards

  private var config: CarouselConfig

  @GestureState private var isDetectingLongPress = false

  @State private var offset: CGFloat = 0
  @State private var gestureOffset: CGFloat = 0

  private let spacing: CGFloat

  init(
    cardWidth: CGFloat, selected: Int = 0, spacing: CGFloat = 20,
    @ViewBuilder cards: @escaping () -> Cards
  ) {
    self.config = CarouselConfig()
    self.config.cardWidth = cardWidth
    self.config.selected = selected
    
    self.spacing = spacing

    self.cards = cards()
  }

  func offset(for index: Int, geometry: GeometryProxy) -> CGFloat {
    return (geometry.size.width - self.config.cardWidth) / 2 - CGFloat(self.config.selected)
      * (self.config.cardWidth + spacing)
  }

  var body: some View {
    GeometryReader {
      geometry in
      HStack(alignment: .center, spacing: self.spacing) {
        cards
          .environmentObject(config)
      }
      .offset(x: offset + gestureOffset)
      .onAppear {
        self.offset = self.offset(for: self.config.selected, geometry: geometry)
      }
      .gesture(
        DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
          self.gestureOffset = currentState.translation.width

        }.onEnded { value in
          self.offset += self.gestureOffset
          self.gestureOffset = 0
          if value.translation.width < -(geometry.size.width / 3) {
            self.config.selected = min(self.config.selected + 1, self.config.cardCount - 1)
          } else if value.translation.width > (geometry.size.width / 3) {
            self.config.selected = max(0, self.config.selected - 1)
          }
//          withAnimation(.spring()) {
//            print(self.config.selected)
            self.offset = self.offset(for: self.config.selected, geometry: geometry)
//          }
        })
    }
  }
}

struct CarouselCard<Content: View>: View {
  @EnvironmentObject fileprivate var config: CarouselConfig

  let content: Content
  @State private var cardId: Int? = nil
  
  var isActive: Bool {
    // The cards are numbered in reverse order
    return cardId == config.cardCount - config.selected - 1
  }

  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content()
  }

  var body: some View {
    content
      .frame(width: config.cardWidth)
      .scaleEffect(isActive ? 1 : 0.8)
      .animation(.easeInOut, value: isActive)
      .zIndex(isActive ? 1 : 0)
      .onAppear {
        self.cardId = self.config.cardCount
        self.config.cardCount += 1
      }
  }
}

struct Carousel_Previews: PreviewProvider {
  static var previews: some View {
    Carousel(cardWidth: 200, spacing: 10) {
      CarouselCard {
        Text("First Card")
          .frame(width: 200, height: 200)
          .background(Color.blue)
      }
      CarouselCard {
        Text("Second Card")
          .frame(width: 150, height: 300)
          .background(Color.red)
      }
      CarouselCard {
        Text("Third Card")
          .frame(width: 200, height: 250)
          .background(Color.yellow)
      }
      CarouselCard {
        Text("Fourth Card")
          .frame(width: 200, height: 150)
          .background(Color.green)
      }
    }
  }
}
