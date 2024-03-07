//
//  SearchController.swift
//  MovieApp
//
//  Created by Ziyadkhan on 09.12.23.
//

import UIKit

class SearchController: UIViewController {
    
    @IBOutlet weak var movieCollection: UICollectionView!
   
    let viewmodel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @IBAction func searchTextField(_ sender: UITextField) {
        if let text = sender.text {
            viewmodel.getSearch(movieKey: text)
            movieCollection.reloadData()
        } else  {
            viewmodel.clearItems()
            movieCollection.reloadData()
        }
    }
}
//MARK: Collection Functions
extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewmodel.searchedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configureData(data: viewmodel.searchedMovies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showMovieInfo(movieID: viewmodel.searchedMovies[indexPath.item].id ?? 0)
    }
}


//MARK: Functions
extension SearchController {
    func configureUI() {
        movieCollection.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    }
    
    func showMovieInfo(movieID: Int) {
        let coordinator = MovieInfoCoordinator(movieID: movieID, navigationController: navigationController ?? UINavigationController())
        coordinator.start()
    }
    
}
