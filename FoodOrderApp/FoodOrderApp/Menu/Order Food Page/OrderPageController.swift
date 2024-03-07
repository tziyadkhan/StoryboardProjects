//
//  OrderPageController.swift
//  FoodOrderApp
//
//  Created by Ziyadkhan on 09.10.23.
//

import UIKit

class OrderPageController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    var items = [CuisineModel]()
    let parser = Parser()
    var basketOrderPage = [MealModel]()
    var onBasketUpdated: (([MealModel]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
        collection.register(UINib(nibName: "FoodListCell", bundle: nil), forCellWithReuseIdentifier: "FoodListCell")
        title = "Order Page"
        parser.parseJsonFile { items in
            self.items = items
            self.collection.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Yemekler orderdeki \(basketOrderPage)")
    }

}

extension OrderPageController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderPageCell", for: indexPath) as! OrderPageCell
        cell.cuisineImageView.image = UIImage(named: items[indexPath.row].cuisineImage ?? "")
        cell.cuisineNameLabel.text = items[indexPath.row].cuisine
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MealPageController") as! MealPageController
        controller.itemsMeal = items[indexPath.row].meals ?? [MealModel]()
        controller.onBasketUpdated = { updatedBasket in
            self.basketOrderPage = updatedBasket
            self.onBasketUpdated?(self.basketOrderPage) // Meal'den Ordere arrayi getirmeyim
        }
        navigationController?.show(controller, sender: nil)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 120, height: 100 )
    }
    
    
}


// Sebet iconu ve ishleme mexanizmi
extension OrderPageController {
    @objc func configureItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "basket"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(basketPage))
}
    @objc func basketPage() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "BasketPageController") as! BasketPageController
        self.navigationController?.show(controller, sender: nil)
        controller.basket = basketOrderPage
    }
}

