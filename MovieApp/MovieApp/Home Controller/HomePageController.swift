//
//  HomePageController.swift
//  MovieApp
//
//  Created by Ziyadkhan on 03.12.23.
//

import UIKit

class HomePageController: UIViewController {
    
    @IBOutlet weak var movieCategoryCollection: UICollectionView!
    
    
    let viewModel = HomePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configureUI()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        showSearchController()
    }
    
}

//MARK: Collections
extension HomePageController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movieItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.movieItems[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.delegate = self
        cell.seeAllDelegate = self
        cell.configure(title: item.title, movies: item.movies)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 288)
    }
}

//MARK: Delegates
extension HomePageController: MovieSelectCellDelegate, DidButtonTappedDelegate {
    func seeAllDelegate(at category: HomeCategory) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SelectedCategoryController") as! SelectedCategoryController
        
        switch (category) {
        case .nowPlaying:
            controller.selectedCategory = HomeEndpoint.nowPlaying.rawValue
            controller.title = category.rawValue
        case .popular:
            controller.selectedCategory = HomeEndpoint.popular.rawValue
            controller.title = category.rawValue
        case .topRated:
            controller.selectedCategory = HomeEndpoint.topRated.rawValue
            controller.title = category.rawValue
        default:
            controller.selectedCategory = HomeEndpoint.upcoming.rawValue
            controller.title = category.rawValue
        }
        navigationController?.show(controller, sender: nil)
    }
    
    func didSelectMovie(at index: Int) {
        print("test \(index)")
        showMovieInfo(movieID: index)
    }
}


//MARK: Functions
extension HomePageController {
    
    func configureViewModel() {
        viewModel.error = { errorMessage in
            print(errorMessage)
        }
        viewModel.success = {
            self.movieCategoryCollection.reloadData()
        }
        viewModel.getItems()
    }
    
    func showMovieInfo(movieID: Int) {
        let coordinator = MovieInfoCoordinator(movieID: movieID,
                                               navigationController: navigationController ?? UINavigationController())
        coordinator.start()
    }
    
    func configureUI() {
        movieCategoryCollection.register(UINib(nibName: "HomeCell", bundle: nil),forCellWithReuseIdentifier: "HomeCell")
        title = "Home"
    }
    
    func showSearchController() {
        let coordinator = SearchCoordinator(navigationController: navigationController ?? UINavigationController())
        coordinator.start()
    }
}
