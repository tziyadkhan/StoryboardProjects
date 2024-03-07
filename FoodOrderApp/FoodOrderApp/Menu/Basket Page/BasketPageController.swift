//
//  BasketPageController.swift
//  FoodOrderApp
//
//  Created by Ziyadkhan on 09.10.23.
//

import UIKit

class BasketPageController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    var basket = [MealModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Basket"
        callBackBasket()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketListCell", for: indexPath) as! BasketListCell
        cell.mealName.text = "\(basket[indexPath.row].mealName ?? "")"
        cell.mealImage.image = UIImage(named: basket[indexPath.row].mealImage ?? "")
        cell.mealPrice.text = "\(basket[indexPath.row].mealPrice ?? 0)AZN"
        return cell
        
    }
    
    func callBackBasket() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MealPageController") as! MealPageController
        controller.onBasketUpdated = { item in
            self.basket = item
        }
    }
    
}
