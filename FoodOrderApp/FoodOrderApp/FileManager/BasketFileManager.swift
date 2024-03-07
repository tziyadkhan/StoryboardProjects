//
//  BasketFileManager.swift
//  FoodOrderApp
//
//  Created by Ziyadkhan on 12.10.23.
//

import Foundation

class BasketFileManager {
    func getFilePath() -> URL {
        let files = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = files[0].appendingPathComponent("basket.json")
        print(path)
        return path
    }
    
    func writeBasketData(baskets: [MealModel]) {
        do {
            let data = try JSONEncoder().encode(baskets)
            try data.write(to: getFilePath())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readBasketData(complete: (([MealModel]) -> Void)) {
        if let data = try? Data(contentsOf: getFilePath()){
            do{
                let items = try JSONDecoder().decode([MealModel].self, from: data)
                complete(items)
            } catch{
                print(error.localizedDescription)
            }
        }
        
    }
}

