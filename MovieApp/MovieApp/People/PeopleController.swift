//
//  PeopleController.swift
//  MovieApp
//
//  Created by Ziyadkhan on 08.12.23.
//

import UIKit

class PeopleController: UIViewController {
    
    @IBOutlet weak var peopleCollection: UICollectionView!
    
    let viewModel = PeopleViewModel()
    let refreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewModel()
    }
}

extension PeopleController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.peopleItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopImageBottomLabelCell", for: indexPath) as! TopImageBottomLabelCell
        cell.configure(data: viewModel.peopleItems[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width/2 - 10, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showPeopleInfo(peopleID: viewModel.peopleItems[indexPath.item].id ?? 1)
    }
}


//MARK: Functions
extension PeopleController {
    
    func showPeopleInfo(peopleID: Int) {
        let coordinator = PeopleInfoCoordinator(navigationController: navigationController ?? UINavigationController(), peopleID: peopleID)
        coordinator.start()
    }
    
    func configureViewModel() {
        viewModel.error = { errorMessage in
            print(errorMessage)
        }
        viewModel.success = {
            self.peopleCollection.reloadData()
            self.refreshController.endRefreshing()
        }
        
        viewModel.getPeopleItems()
    }
    
    func configureUI() {
        title = "People"
        refreshController.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        peopleCollection.refreshControl = refreshController
        peopleCollection.register(UINib(nibName: "TopImageBottomLabelCell", bundle: nil),forCellWithReuseIdentifier: "TopImageBottomLabelCell")
    }
    
    @objc func pullToRefresh() {
        viewModel.reset()
        peopleCollection.reloadData()
        viewModel.getPeopleItems()
    }
}
