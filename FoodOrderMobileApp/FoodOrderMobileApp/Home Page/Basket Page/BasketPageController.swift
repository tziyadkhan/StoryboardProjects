//
//  BasketPageController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 09.11.23.
//

import UIKit
import RealmSwift

class BasketPageController: UIViewController {
    
    @IBOutlet weak var foodDeliveryAmountLabel: UILabel!
    @IBOutlet weak var foodTotalAmount: UILabel!
    @IBOutlet weak var table: UITableView!
    
    let emailSaved = UserDefaults.standard.string(forKey: "enteredEmail")
    let helper = Database()
    var realm = try! Realm()
    var user = [User]()
    var tempFinalMealPrice = 0.0
    var tempUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.reloadData()
        touchGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        user = helper.fetchFromDB()
        if let index = user.firstIndex(where: {$0.email == emailSaved}) {
            let userBasket = user[index]
            tempUser = userBasket
        }
        table.reloadData()
        orderConfig()
    }
    
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    @IBAction func orderNowButton(_ sender: Any) {
        if tempUser.purchase?.mealList.count ?? 0 > 0 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "PaymentPageController") as! PaymentPageController
            controller.userMealPrice = Int(tempFinalMealPrice)
            navigationController?.show(controller, sender: nil)
        } else {
            showAlert(title: "Failed", message: "Empty Basket. Please double check your basket before proceeding the order")
        }
    }
}

extension BasketPageController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tempUser.purchase?.mealList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketListCell", for: indexPath) as! BasketListCell
        
        if tempUser.purchase?.purchaseStatus == "incomplete" {
            cell.fillCell(name: tempUser.purchase?.mealList[indexPath.row].mealName,
                          image: tempUser.purchase?.mealList[indexPath.row].mealImage ?? "",
                          amount: String(tempUser.purchase?.mealList[indexPath.row].mealAmount ?? 0),
                          price: "\(String(tempUser.purchase?.mealList[indexPath.row].mealPrice ?? 0)) ₼")
        } else if tempUser.purchase?.purchaseStatus == "complete" { //order ugurla bitenden sonra basketi temizleyir
            try! self.realm.write {
                tempUser.purchase?.mealList.removeAll()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { _, _, _ in
            self.deleteItem(indexPathRow: indexPath.row)
            self.table.reloadData()
        }
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
// MARK: Functions
extension BasketPageController {
    // Swipe edilan zaman silecek
    func deleteItem(indexPathRow: Int) {
        // Userin databazadaki Purchasini yenileyir
        try! self.realm.write {
            self.tempUser.purchase?.mealList[indexPathRow].mealAmount = 0
            self.tempUser.purchase?.mealList.remove(at: indexPathRow)
        }
        orderConfig()
        self.table.reloadData()
    }
    
    func orderConfig() {
        
        var finalPrice: Double = 0
        if let mealList = tempUser.purchase?.mealList {
            for meal in mealList {
                finalPrice = finalPrice + (Double(meal.mealAmount ?? 0) * (meal.mealPrice ?? 0) )
                tempFinalMealPrice = finalPrice
            }
        }
        if finalPrice > 0 {
            foodTotalAmount.text = ("\(String(finalPrice)) ₼")
            foodDeliveryAmountLabel.text = "Free"
        } else {
            foodTotalAmount.text = "0 ₼"
            foodDeliveryAmountLabel.text = "0 ₼"
        }
        
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Okay", style: .default)
        
        alertController.addAction(okayButton)
        present(alertController, animated: true)
    }
    
    func touchGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                tapGesture.cancelsTouchesInView = false // Allows touch event to pass through to the view hierarchy
                view.addGestureRecognizer(tapGesture)
    }
}
// Realm Path /Users/ziyadkhan/Library/Developer/CoreSimulator/Devices/088998E2-83B3-4D2B-B1D6-8CD936A0125A/data/Containers/Data/Application/9D162F11-BCA2-4E64-8ED9-8D80B91C83E8/Documents/
