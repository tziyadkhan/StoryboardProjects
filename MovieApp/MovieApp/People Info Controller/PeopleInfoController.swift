//
//  PeopleInfoController.swift
//  MovieApp
//
//  Created by Ziyadkhan on 18.12.23.
//

import UIKit

class PeopleInfoController: UIViewController {
    
    @IBOutlet weak var peopleInfoCollection: UICollectionView!
    
    var viewModel: PeopleInfoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureXib()
        configureViewModel()
    }
    
}

extension PeopleInfoController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.peopleInfoItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel?.peopleInfoItems[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopImageBottomLabelCell", for: indexPath) as! TopImageBottomLabelCell
        cell.configure(data: item!)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showMovieInfo(movieID: viewModel?.peopleInfoItems[indexPath.item].id ?? 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width/2-10, height: 280)
    }
}


// MARK: Functions
extension PeopleInfoController {
    
    func configureViewModel() {
        viewModel?.error = { error in
            print(error)
        }
        viewModel?.sucess = {
            self.peopleInfoCollection.reloadData()
        }
        viewModel?.getPeopleInfoItems()
    }
    
    func configureXib() {
        peopleInfoCollection.register(UINib(nibName: "TopImageBottomLabelCell", bundle: nil),forCellWithReuseIdentifier: "TopImageBottomLabelCell")
    }
    
    func showMovieInfo(movieID: Int) {
        let coordinator = MovieInfoCoordinator(movieID: movieID, navigationController: navigationController ?? UINavigationController())
        coordinator.start()
    }
}
