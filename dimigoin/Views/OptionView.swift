//
//  OptionView.swift
//  dimigoin
//
//  Created by 변경민 on 2020/08/09.
//  Copyright © 2020 seohun. All rights reserved.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let name: String
}

struct OptionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var optionAPI: OptionAPI
    @State var selectedMode = 0
    @State private var editMode = EditMode.inactive
    @State var visibleItems: [Item] = [
        Item(name: "시간표"),
        Item(name: "공지사항"),
        Item(name: "급식"),
        Item(name: "인강실 신청")
    ]
    @State var beneduAlert = true
    init(optionAPI: OptionAPI) {
        self.optionAPI = optionAPI
    }
    var body: some View {
        NavigationView {
            List {
//                Section(header: HStack {
//                    Image(systemName: "slider.horizontal.3")
//                    Text("순서 편집")
//                    Spacer()
//                    Button(action: {
//                        if(editMode == EditMode.active) {
//                            editMode = EditMode.inactive
//                        } else {
//                            editMode = EditMode.active
//                        }
//                    }) {
//                        if(editMode == EditMode.active) {
//                            Text("완료")
//                        } else {
//                            Text("편집하기").highlightRed()
//                        }
//                    }
//                },
//                    footer: Button(action: {
//                        // reset items list
//                            resetItems()
//                        }) {
//                            Text("초기화 하기").highlight()
//                        })
//                {
//                    ForEach(visibleItems) { item in
//                        Text(item.name).body()
//                    }
//                    .onMove(perform: onMove)
//                }
                Section(header: HStack {
                    Image(systemName: "eyedropper")
                    Text("실험실")
                },
                    footer: Text("테스트중인 기능들로 완벽하지 않을 수 있습니다.").caption3())
                {
                    Toggle(isOn: $optionAPI.beneduAlert) {
                        Text("베네듀 알림").body()
                    }
                    Picker(selection: $optionAPI.selectedMode, label: Text("화이트/다크모드").body()) {
                        ForEach(0 ..< optionAPI.modes.count) {
                            Text(optionAPI.modes[$0]).body()
                        }
                    }
                }
            }.listStyle(GroupedListStyle())
            .navigationBarTitle("설정")
            .navigationBarItems(trailing:
                Button(action: {
                    self.dismiss()
                }){
                    Image(systemName: "xmark").resizable().frame(width: 20, height: 20)
                }
            )
            .environment(\.editMode, $editMode)
            .onDisappear(perform: {
                optionAPI.saveOptions()
            })
        }
    }
    
//    private func onMove(source: IndexSet, destination: Int) {
//        visibleItems.move(fromOffsets: source, toOffset: destination)
//    }
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
    func resetItems() {
        visibleItems = [
            Item(name: "시간표"),
            Item(name: "공지사항"),
            Item(name: "급식"),
            Item(name: "인강실 신청")
        ]
    }
    
}

//struct OptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        OptionView()
//    }
//}
