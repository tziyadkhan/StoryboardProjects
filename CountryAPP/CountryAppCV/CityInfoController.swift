//
//  CityInfoController.swift
//  CountryAppCV
//
//  Created by Ziyadkhan on 24.09.23.
//

import UIKit

class CityInfoController: UIViewController {

    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityInfoLabel: UILabel!
    var city: City?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = city?.name ?? ""
        cityInfoLabel.text = city?.info ?? ""
        cityImageView.image = UIImage(named: city?.image ?? "")
    
    }

}
