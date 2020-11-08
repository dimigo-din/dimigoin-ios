//
//  ContentView.swift
//  watchApp Extension
//
//  Created by 변경민 on 2020/10/26.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var mealAPI = MealAPI()
    var body: some View {
        List {
            Section {
                NavigationLink(destination: mealDetailView(mealAPI: mealAPI, mealType: .breakfast)) {
                    Text("아침")
                }
                NavigationLink(destination: mealDetailView(mealAPI: mealAPI, mealType: .lunch)) {
                    Text("점심")
                }
                NavigationLink(destination: mealDetailView(mealAPI: mealAPI, mealType: .dinner)) {
                    Text("저녁")
                }
            }
        }
        .navigationTitle(Text(getDate()))
    }
}
struct mealDetailView: View {
    @ObservedObject var mealAPI: MealAPI
    var mealType: MealType
    var body: some View {
        NavigationView {
            ZStack {
                Image("Logo").resizable().frame(width: 80, height: 92).opacity(0.3)
                VStack {
                    Text(getDate()).accent().bold()
                    Text(getMealMenu(meal: mealAPI.meals[getDayFromString(getDay())], mealType: mealType)).bold().padding()
                }
            }
            .navigationTitle("디미고인")
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
