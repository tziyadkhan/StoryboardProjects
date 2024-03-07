//
//  FoodListCell.swift
//  FoodOrderApp
//
//  Created by Ziyadkhan on 09.10.23.
//

import UIKit

protocol FoodCellDelegate {
    func addButtonAction(index: Int)
}

class FoodListCell: UICollectionViewCell {
    var basket = [CuisineModel]()

    @IBOutlet weak var listCellLabel: UILabel!
    @IBOutlet weak var listCellImage: UIImageView!

    var delegate: FoodCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    @IBAction func addButton(_ sender: Any) {
        delegate?.addButtonAction(index: self.tag)
    }
    
}
