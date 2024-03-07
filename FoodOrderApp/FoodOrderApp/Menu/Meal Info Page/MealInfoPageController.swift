//
//  MealInfoPageController.swift
//  FoodOrderApp
//
//  Created by Ziyadkhan on 09.10.23.
//

import UIKit

class MealInfoPageController: UIViewController {
    
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealPriceLabel: UILabel!
    @IBOutlet weak var mealContentLabel: UILabel!
    
    var meal: MealModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meal info"
        showMealInfo()

    }

    func showMealInfo() {
        mealImageView.image = UIImage(named: meal?.mealImage ?? "")
        mealNameLabel.text = "Meal name: \(meal?.mealName ?? "")"
        mealContentLabel.text = "Meal content: \(meal?.mealContent ?? "")"
        mealPriceLabel.text = "Meal price: \(meal?.mealPrice ?? 0) AZN"
    }

}
