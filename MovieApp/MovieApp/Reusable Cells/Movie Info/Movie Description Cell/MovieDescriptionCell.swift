//
//  MovieDescriptionCell.swift
//  MovieApp
//
//  Created by Ziyadkhan on 14.12.23.
//

import UIKit

class MovieDescriptionCell: UICollectionViewCell {

    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(description: String?) {
        movieDescriptionLabel.text = description
    }

}
