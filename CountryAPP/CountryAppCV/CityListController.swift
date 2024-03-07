//
//  CityListController.swift
//  CountryAppCV
//
//  Created by Ziyadkhan on 25.09.23.
//

import UIKit

class CityListController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var city = [City]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        city.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityListCell", for: indexPath) as! CityListCell
        cell.cityNameLabel.text = city[indexPath.row].name
        cell.cityImage.image = UIImage(named: city[indexPath.row].image)
        //cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 120, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "CityInfoController") as! CityInfoController
        controller.city = city[indexPath.row]
        navigationController?.show(controller, sender: nil)
    }

}
