//
//  MealPageController.swift
//  FoodOrderApp
//
//  Created by Ziyadkhan on 09.10.23.
//

import UIKit
class MealPageController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!

    var itemsMeal = [MealModel]()
    var basketMeal = [MealModel]()
    var onBasketUpdated: (([MealModel]) -> Void)?
    
    let helper = BasketFileManager()
    var basketTemp = [MealModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meal Page"
        collection.register(UINib(nibName: "FoodListCell", bundle: nil),forCellWithReuseIdentifier: "FoodListCell")
        collection.reloadData()
        
        helper.readBasketData { basketItems in
            self.basketTemp = basketItems
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
}
    extension MealPageController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            itemsMeal.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodListCell", for: indexPath) as! FoodListCell
            cell.listCellImage.image = UIImage(named: self.itemsMeal[indexPath.row].mealImage ?? "")
            cell.listCellLabel.text = self.itemsMeal[indexPath.row].mealName
            cell.delegate = self
            cell.tag = indexPath.row
//            cell.listCellImage.backgroundColor = .red
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let controller = storyboard?.instantiateViewController(withIdentifier: "MealInfoPageController") as! MealInfoPageController
            controller.meal = itemsMeal[indexPath.row]
            navigationController?.show(controller, sender: nil)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            CGSize(width: 120, height: 120)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
                return UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 64)
            }
    }




// FoodCellDelegate - Sebete elave etmek
extension MealPageController: FoodCellDelegate {
    func addButtonAction(index: Int) {
        showAlert(title: "", message: "\(itemsMeal[index].mealName ?? "") Səbətə əlavə olundu")
        self.basketMeal.append(itemsMeal[index])
        basketTemp.append(contentsOf: self.basketMeal)
        helper.writeBasketData(baskets: basketTemp)
        onBasketUpdated?(basketTemp)
    }
}


//Show Alert
extension MealPageController {
        func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
            let returnButton = UIAlertAction(title: "Səbətə bax", style: .default) { (_) in
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "BasketPageController") as! BasketPageController
                controller.basket = self.basketTemp
                self.navigationController?.show(controller, sender: nil)
            }
            let okayButton = UIAlertAction(title: "Okay", style: .default)
            alertController.addAction(returnButton)
            alertController.addAction(okayButton)
            self.present(alertController, animated: true)
        }
}
