//
//  Food.swift
//  FoodOrderApp
//
//  Created by Ziyadkhan on 09.10.23.
//

import Foundation

struct CuisineModel: Codable {
    var cuisine: String?
    var cuisineImage: String?
    var meals: [MealModel]?
}

struct MealModel: Codable {
    var mealName: String?
    var mealImage: String?
    var mealPrice: Int?
    var mealContent: String?
    var mealAmount: Int?
}


