//
//  HomePageController.swift
//  FoodOrderApp
//
//  Created by Ziyadkhan on 08.10.23.
//

import UIKit

class HomePageController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    var userHome = [User]()
    var menu = Menu.allCases
    var basketHomePage = [MealModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home Page"
//        print("Baslangic home page \(userHome)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        print("Yemek homedaki \(basketHomePage)")
//        print("userhome  -----> \(userHome)")
    }

}

extension HomePageController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageCell", for: indexPath) as! HomePageCell
        cell.textLabel?.text = menu[indexPath.row].rawValue
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch menu[indexPath.row] {
        case .profile:
            profile()
        case .orderFood:
            orderFood()
        default:
            basketPage()
        }
    }
    
}

extension HomePageController {
    func profile() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ProfilePageController") as! ProfilePageController
        navigationController?.show(controller, sender: nil)
        
        controller.userProfile = userHome
//        print("profile basanda \(userHome)")
    }
    
    func orderFood() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "OrderPageController") as! OrderPageController
        // Orderdeki basketi Home'a getirmek ucun
        controller.onBasketUpdated = {updatedBasket in
            self.basketHomePage = updatedBasket
        }
        navigationController?.show(controller, sender: nil)
    }
    
    func basketPage() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "BasketPageController") as! BasketPageController
        navigationController?.show(controller, sender: nil)
        controller.basket = basketHomePage
    }
}
