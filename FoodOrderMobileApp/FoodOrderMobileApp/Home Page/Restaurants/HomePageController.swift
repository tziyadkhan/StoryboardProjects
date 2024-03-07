//
//  HomePageController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 04.11.23.
//

import UIKit

class HomePageController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBackground: UIView!
    
    var items = [RestaurantModel]()
    let parser = Parser()
    var searching = false
    var backupItems = [RestaurantModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBackground.layer.cornerRadius = 20
        
        parser.parseJsonFile { parsedItems in
            self.items = parsedItems
        }
        
        backupItems = items //search box ucun
        touchGesture()
    }
    
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    @IBAction func searchTextField(_ sender: UITextField) {
        if let searchText = sender.text, !searchText.isEmpty {
            searching = true
            items = items.filter { restaurant in
                if let restaurant = restaurant.restaurantName {
                    return restaurant.lowercased().contains(searchText.lowercased())
                }
                return false
            }
        } else {
            searching = false
            items.removeAll()
            items = backupItems
        }
        collection.reloadData()
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        showAlert(title: "Warning", message: "Are you sure you want to exit?")
    }
}

// MARK: Collection View
extension HomePageController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantsCell", for: indexPath) as! RestaurantsCell
        cell.addItemToCell(name: items[indexPath.item].restaurantName,
                           resImage: items[indexPath.item].restaurantImage)
        
        cell.restaurantInfoCallBack = {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantInfoController") as! RestaurantInfoController
            controller.restaurant = self.items[indexPath.item]
            self.navigationController?.show(controller, sender: nil)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "FoodListController") as! FoodListController
        controller.foodList = self.items[indexPath.item].mealList ?? [MealModel]()
        navigationController?.show(controller, sender: nil)
    }
}

// MARK: Functions
extension HomePageController {
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.setValue(false, forKey: "loggedIN") // Setting the flag
            sceneDelegate.loginPage(windowScene: scene)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okaybutton = UIAlertAction(title: "Log out", style: .default) { (_) in
            self.setRoot()
        }
        let cancelButton = UIAlertAction(title: "Stay", style: .cancel)
        
        alertController.addAction(okaybutton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
    
    func touchGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                tapGesture.cancelsTouchesInView = false // Allows touch event to pass through to the view hierarchy
                view.addGestureRecognizer(tapGesture)
    }
}
