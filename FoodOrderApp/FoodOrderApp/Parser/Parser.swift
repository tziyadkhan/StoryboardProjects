//
//  Parser.swift
//  FoodOrderApp
//
//  Created by Ziyadkhan on 09.10.23.
//

import Foundation

class Parser {
    func parseJsonFile(completion: ([CuisineModel]) -> Void) {
        if let file = Bundle.main.url(forResource: "FoodData", withExtension: "json"){
            do {
                let data = try Data(contentsOf: file)
                let items = try JSONDecoder().decode([CuisineModel].self, from: data)
                completion(items)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
