//
//  Dimibob.swift
//  dimigoin
//
//  Created by 엄서훈 on 2020/06/27.
//  Copyright © 2020 seohun. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MealAPI: ObservableObject {
    @Published var meals = [Dimibob(breakfast: "급식 정보가 없습니다.",
                                  lunch: "급식 정보가 없습니다.",
                                  dinner: "급식 정보가 없습니다."),
                            Dimibob(breakfast: "급식 정보가 없습니다.",
                                  lunch: "급식 정보가 없습니다.",
                                  dinner: "급식 정보가 없습니다."),
                            Dimibob(breakfast: "급식 정보가 없습니다.",
                                  lunch: "급식 정보가 없습니다.",
                                  dinner: "급식 정보가 없습니다."),
                            Dimibob(breakfast: "급식 정보가 없습니다.",
                                  lunch: "급식 정보가 없습니다.",
                                  dinner: "급식 정보가 없습니다."),
                            Dimibob(breakfast: "급식 정보가 없습니다.",
                                  lunch: "급식 정보가 없습니다.",
                                  dinner: "급식 정보가 없습니다."),
                            Dimibob(breakfast: "급식 정보가 없습니다.",
                                  lunch: "급식 정보가 없습니다.",
                                  dinner: "급식 정보가 없습니다."),
                            Dimibob(breakfast: "급식 정보가 없습니다.",
                                  lunch: "급식 정보가 없습니다.",
                                  dinner: "급식 정보가 없습니다.")]
    init() {
        getWeeklyMeals()
    }
    func getWeeklyMeals() {
        getMeals(from: .mon)
        getMeals(from: .tue)
        getMeals(from: .wed)
        getMeals(from: .thu)
        getMeals(from: .fri)
        getMeals(from: .sat)
        getMeals(from: .sun)
        
    }
    func getMeals(from weekDay: Weekday){
        print("get meals from \(getFormattedDate(weekday: weekDay))")
        let url = "https://api.dimigo.in/dimibobs/\(getFormattedDate(weekday: weekDay))"
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseData { response in
            let json = JSON(response.value!)
            self.meals[weekDay.rawValue-1].breakfast = json["breakfast"].string!
            self.meals[weekDay.rawValue-1].lunch = json["lunch"].string!
            self.meals[weekDay.rawValue-1].dinner = json["dinner"].string!
//            self.dubugMeal()
        }
    }
    func getTodayMeal() -> Dimibob{
        return meals[getIntDay()-1]
    }
    func dubugMeal() {
        print(meals)
    }
}

enum MealType:Int {
    case breakfast = 0
    case lunch = 1
    case dinner = 2
}

struct Dimibob: Codable, Identifiable {
    var id = UUID()
    var breakfast: String
    var lunch: String
    var dinner: String
}

func getMealMenu(meal: Dimibob, mealType: MealType) -> String{
    switch mealType {
        case .breakfast: return meal.breakfast
        case .lunch: return meal.lunch
        case .dinner: return meal.dinner
    }
}
    
func getMealType() -> MealType {
    let hour = Calendar.current.component(.hour, from: Date())
    if Int(hour) <= 9 || Int(hour) >= 21 { // 오후 9시 ~ 오전 9시 -> 아침
        return .breakfast
    }
    else if Int(hour) <= 14 { // 오전 10시 ~ 오후 2시 -> 점심
        return .lunch
    }
    else if Int(hour) <= 21 { // 오후 3시 ~ 오후 9시 -> 저녁
        return .dinner
    }
    else {
        return .breakfast
    }
}

let dummyDimibob = Dimibob(
    breakfast: "닭다리삼계죽 | 보조밥 | 고기산적&케찹 | 호박버섯볶음 | 건새우마늘쫑볶음 | 깍두기 | 모듬과일 | 미니크라상&잼 | 푸딩",
    lunch: "라면&보조밥 | 소떡소떡 | 야끼만두&초간장 | 참나물만다린무침 | 단무지 | 포기김치 | 우유빙수",
    dinner: "김치참치마요덮밥 | 쌀밥 | 콩나물국 | 치즈스틱 | 실곤약치커리무침 | 깍두기 | 미니딸기파이"
)


