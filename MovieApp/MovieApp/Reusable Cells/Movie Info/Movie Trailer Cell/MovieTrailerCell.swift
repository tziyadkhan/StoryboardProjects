//
//  MovieTrailerCell.swift
//  MovieApp
//
//  Created by Ziyadkhan on 14.12.23.
//

import UIKit

class MovieTrailerCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func showImage(image: String?) {
        movieImage.showImage(imageURL: image)
    }

}
