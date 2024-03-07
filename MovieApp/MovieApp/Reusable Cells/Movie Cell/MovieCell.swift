//
//  MovieCell.swift
//  MovieApp
//
//  Created by Ziyadkhan on 09.12.23.
//

import UIKit

protocol MovieCellProtocol {
    var ratingText: String {get}
    var descriptionText: String {get}
    var titleText: String {get}
    var movieImage: String {get}
}

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureData(data: MovieCellProtocol) {
        movieRatingLabel.text = "⭐ \(data.ratingText) / 10 IMDB"
        movieDescriptionLabel.text = data.descriptionText
        movieTitleLabel.text = data.titleText
        movieImage.showImage(imageURL: data.movieImage)
    }
}
