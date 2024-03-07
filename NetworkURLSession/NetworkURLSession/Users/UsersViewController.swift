//
//  UsersViewController.swift
//  NetworkURLSession
//
//  Created by Ziyadkhan on 27.11.23.
//

import UIKit

class UsersViewController: UIViewController {    
    
    @IBOutlet weak var collection: UICollectionView!
    let userViewModel = UsersViewModel(service: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userViewModel.getUserItems {
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
        }
    }
}

extension UsersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userViewModel.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCollectionCell", for: indexPath) as! UsersCollectionCell
        guard let userItem = userViewModel.items?[indexPath.row] else {return UICollectionViewCell()}
        cell.fillCell(fullname: userItem.name,
                      email: userItem.email)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "UsersInfoController") as! UsersInfoController
        guard let selectedUserID  = userViewModel.items?[indexPath.row].id else {return}
        controller.selectedUserID = selectedUserID
        navigationController?.show(controller, sender: nil)
    }
}
