//
//  FoodListController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 07.11.23.
//

import UIKit
import RealmSwift


class FoodListController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBackground: UIView!
    
    var realm = try! Realm()
    var foodList = [MealModel]()
    var backupFoodList = [MealModel]()
    var searching = false
    var user = [User]()
    let helper = Database()
    let emailSaved = UserDefaults.standard.string(forKey: "enteredEmail")
    var tempUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBackground.layer.cornerRadius = 20
        backupFoodList = foodList  //search box ucundu
        touchGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        user = helper.fetchFromDB()
        if let index = user.firstIndex(where: {$0.email == emailSaved}) { //her userin individual akkauntu ile girmesi ucundu
            let userFetch = user[index]
            tempUser = userFetch
        }
    }
    
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    @IBAction func searchTextField(_ sender: UITextField) {
        if let searchText = sender.text, !searchText.isEmpty {
            searching = true
            foodList = foodList.filter { food in
                if let food = food.mealName {
                    return food.lowercased().contains(searchText.lowercased())
                }
                return false
            }
        } else {
            searching = false
            foodList.removeAll()
            foodList = backupFoodList
        }
        collection.reloadData()
    }
}

extension FoodListController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodListCell", for: indexPath) as! FoodListCell
        cell.fillCell(name: foodList[indexPath.item].mealName,
                      image: foodList[indexPath.item].mealImage,
                      price: String(" \(foodList[indexPath.item].mealPrice  ?? 0) ₼"),
                      amount: String(foodList[indexPath.item].mealAmount ?? 0))
        
        // Yemek sayinda artib/azalma olsa, yenilesin
        cell.foodAmountCallBack = { [weak self] amount in
            self?.updateAmount(indexPath: indexPath, newAmount: amount)
            cell.fillCell(name: self?.foodList[indexPath.item].mealName,
                          image: self?.foodList[indexPath.item].mealImage,
                          price: String(" \(self?.foodList[indexPath.item].mealPrice ?? 0) ₼"),
                          amount: String(self?.foodList[indexPath.item].mealAmount ?? 0))
        }
        // Baskete elave etsin
        cell.addToBasketCallBack = { [weak self] in
            self?.addToBasket(indexPath: indexPath)
            cell.foodAmountLabel.text = String(0)
        }
        
        return cell
    }
}

// MARK: Functions
extension FoodListController {
    
    func addToBasket(indexPath: IndexPath) {
        let selectedMeal = self.foodList[indexPath.item]
        if let existingMeal = tempUser.purchase?.mealList.first(where: { $0.mealName == selectedMeal.mealName }) {
            // Yemek basketde var idise, sadece sayini yenile
            do {
                try self.realm.write {
                    existingMeal.mealAmount = selectedMeal.mealAmount
                    tempUser.purchase?.purchaseStatus = "incomplete"
                }
                informAlert(title: "Success", message: "Meal added to basket") //ekranda bu gorsenir
            } catch {
                print("Error updating meal count: \(error)")
            }
        } else {
            // Eger yemek basketde yoxdusa, sayi nedirse ona uygun baskete elave et
            let newMeal = MealModel()
            newMeal.mealName = selectedMeal.mealName
            newMeal.mealImage = selectedMeal.mealImage
            newMeal.mealPrice = selectedMeal.mealPrice
            newMeal.mealContent = selectedMeal.mealContent
            newMeal.mealAmount = selectedMeal.mealAmount
            newMeal.mealDeliveryTime = selectedMeal.mealDeliveryTime
            
            do {
                try self.realm.write {
                    tempUser.purchase?.mealList.append(newMeal)
                    tempUser.purchase?.purchaseStatus = "incomplete"
                }
                informAlert(title: "Success", message: "Meal added to basket")
            } catch {
                print("Error adding meal to basket: \(error)")
            }
        }
    }
    // Update the amount in your data source (foodList) accordingly
    func updateAmount(indexPath: IndexPath, newAmount: Int) {
        self.foodList[indexPath.item].mealAmount = newAmount
        if let cell = collection.cellForItem(at: indexPath) as? FoodListCell {
            cell.foodAmountLabel.text = String(newAmount)
        }
    }
    // Sebete elave olunanda bildirish verir
    func informAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okayButton)
        self.present(alertController, animated: true)
    }
    
    func touchGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                tapGesture.cancelsTouchesInView = false // Allows touch event to pass through to the view hierarchy
                view.addGestureRecognizer(tapGesture)
    }
}
