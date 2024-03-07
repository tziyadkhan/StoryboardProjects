//
//  MovieInfoController.swift
//  MovieApp
//
//  Created by Ziyadkhan on 14.12.23.
//

import UIKit

class MovieInfoController: UIViewController {
    
    @IBOutlet weak var movieInfoCollection: UICollectionView!
    var viewModel: MovieInfoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureXibs()
        configureViewModel()
    }
}

extension MovieInfoController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.movieItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel?.movieItems[indexPath.item]
        
        switch item?.type {
            
        case .poster(let path):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieTrailerCell", for: indexPath) as! MovieTrailerCell
            cell.showImage(image: path)
            return cell
            
        case .title(let title):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieNameCell", for: indexPath) as! MovieNameCell
            cell.configData(title: title)
            return cell
            
        case .info(let info):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailsCell", for: indexPath) as! MovieDetailsCell
            cell.configureCell(data: info, genre: info.genres)
            return cell
            
        case .description(let description):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDescriptionCell", for: indexPath) as! MovieDescriptionCell
            cell.config(description: description)
            return cell
            
        case .cast(let cast):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCell", for: indexPath) as! MovieCastCell
            cell.cast = cast
            return cell
            
        case .none:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = viewModel?.movieItems[indexPath.item]
        switch item?.type {
        case .poster:
            return CGSize(width: collectionView.frame.width - 32, height: 240)
        case .title:
            return CGSize(width: collectionView.frame.width - 32, height: 50)
        case .info:
            return CGSize(width: collectionView.frame.width - 32, height: 130)
        case .description:
            return CGSize(width: collectionView.frame.width - 32, height: 144)
        case .cast:
            return CGSize(width: collectionView.frame.width - 32, height: 150)
        case .none:
            return CGSize()
        }
    }
}

// MARK: Functions
extension MovieInfoController {
    
    func configureXibs() {
        movieInfoCollection.register(UINib(nibName: "MovieTrailerCell", bundle: nil), forCellWithReuseIdentifier: "MovieTrailerCell")
        movieInfoCollection.register(UINib(nibName: "MovieNameCell", bundle: nil), forCellWithReuseIdentifier: "MovieNameCell")
        movieInfoCollection.register(UINib(nibName: "MovieDetailsCell", bundle: nil), forCellWithReuseIdentifier: "MovieDetailsCell")
        movieInfoCollection.register(UINib(nibName: "MovieDescriptionCell", bundle: nil), forCellWithReuseIdentifier: "MovieDescriptionCell")
        movieInfoCollection.register(UINib(nibName: "MovieCastCell", bundle: nil), forCellWithReuseIdentifier: "MovieCastCell")
    }
    
    func configureViewModel() {
        viewModel?.error = { errorMessage in
            print(errorMessage)
        }
        viewModel?.success = {
            self.movieInfoCollection.reloadData()
        }
        viewModel?.getMovieInfoItems()
    }
}
