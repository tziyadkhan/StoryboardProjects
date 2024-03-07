//
//  TopImageBottomLabelCell.swift
//  MovieApp
//
//  Created by Ziyadkhan on 07.12.23.
//

import UIKit

protocol TopImageBottomLabelProtocol {
    var titleText: String {get}
    var imagePath: String {get}
}

class TopImageBottomLabelCell: UICollectionViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.layer.cornerRadius = 16
    }
    
    func configure(data: TopImageBottomLabelProtocol) {
        movieTitleLabel.text = data.titleText
        movieImage.showImage(imageURL: data.imagePath)
    }
    
    
}
