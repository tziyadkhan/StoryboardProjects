//
//  MovieNameCell.swift
//  MovieApp
//
//  Created by Ziyadkhan on 14.12.23.
//

import UIKit

class MovieNameCell: UICollectionViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func seemoreActionButton(_ sender: Any) {
    }
    
    func configData(title: String?) {
        movieTitleLabel.text = title
    }
    
}
