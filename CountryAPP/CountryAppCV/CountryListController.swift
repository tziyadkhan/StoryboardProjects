//
//  CountryListController.swift
//  CountryAppCV
//
//  Created by Ziyadkhan on 24.09.23.
//

import UIKit

class CountryListController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var countries = [Country]()
    let countryInfoData = CountryInfoData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries = countryInfoData.countries
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryListCell", for: indexPath) as! CountryListCell
        cell.countryNameLabel.text = countries[indexPath.row].name
        cell.flagImage.image = UIImage(named: countries[indexPath.row].flag)
        //cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 120, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "CityListController") as! CityListController
        controller.city = countries[indexPath.row].cities
        navigationController?.show(controller, sender: nil)
    }

}
