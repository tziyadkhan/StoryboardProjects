//
//  MovieCastCell.swift
//  MovieApp
//
//  Created by Ziyadkhan on 14.12.23.
//

import UIKit

class MovieCastCell: UICollectionViewCell {
    
    @IBOutlet weak var actorsCastCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        actorsCastCollection.register(UINib(nibName: "ActorsCell", bundle: nil), forCellWithReuseIdentifier: "ActorsCell")
    }
    
    var cast: [CastResult]?
    
    @IBAction func seemoreActionButton(_ sender: Any) {
    }
    
}

extension MovieCastCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorsCell", for: indexPath) as! ActorsCell
        cell.actorImage.showImage(imageURL: cast?[indexPath.item].profilePath)
        cell.actorNameLabel.text = cast?[indexPath.item].name
        return cell
    }
}
