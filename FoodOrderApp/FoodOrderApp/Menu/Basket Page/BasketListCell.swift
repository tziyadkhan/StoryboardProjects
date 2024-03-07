//
//  BasketListCell.swift
//  FoodOrderApp
//
//  Created by Ziyadkhan on 10.10.23.
//

import UIKit

class BasketListCell: UITableViewCell {
    
    
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
