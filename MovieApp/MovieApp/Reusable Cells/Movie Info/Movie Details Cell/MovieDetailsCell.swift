//
//  MovieDetailsCell.swift
//  MovieApp
//
//  Created by Ziyadkhan on 14.12.23.
//

import UIKit

protocol MovieDetailsCellProtocol {
    var ratingText: String {get}
    var lengthText: String {get}
    var releaseDateText: String {get}
    var languageText: String {get}
}

class MovieDetailsCell: UICollectionViewCell {

    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieLength: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var genreCollection: UICollectionView!
    
    var genres: [Genre]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        genreCollection.register(UINib(nibName: "GenresCell", bundle: nil), forCellWithReuseIdentifier: "GenresCell")
    }
    
    func configureCell(data: MovieDetailsCellProtocol, genre: [Genre]) {
        movieRatingLabel.text = "⭐ \(data.ratingText) / 10 IMDb  "
        movieLength.text = "\(data.lengthText)min"
        movieReleaseDate.text = data.releaseDateText
        movieLanguage.text = data.languageText
        genres = genre
    }
}

extension MovieDetailsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genres?.count ?? 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCell", for: indexPath) as! GenresCell
        cell.genreLabel.text = genres?[indexPath.item].name ?? "bosh"
        return cell
    }
}
