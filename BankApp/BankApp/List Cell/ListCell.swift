//
//  ListCell.swift
//  BankApp
//
//  Created by Ziyadkhan on 16.10.23.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var listLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
