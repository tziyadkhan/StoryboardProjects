//
//  UsersInfoController.swift
//  NetworkURLSession
//
//  Created by Ziyadkhan on 27.11.23.
//

import UIKit

class UsersInfoController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var selectedUserID: Int?
    let userInfoViewModel = UserInfoViewModel(service: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoViewModel.getUserItems(userID: selectedUserID) {
            DispatchQueue.main.async {
                self.collection.reloadData()
                self.title = "\(self.userInfoViewModel.items?.name ?? "")"
            }
        }
    }
}

extension UsersInfoController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersInfoCollectionCell", for: indexPath) as! UsersInfoCollectionCell
        cell.fillCell(username: userInfoViewModel.items?.username,
                      email: userInfoViewModel.items?.email,
                      phone: userInfoViewModel.items?.phone,
                      company: userInfoViewModel.items?.company?.name,
                      address:  ("\(userInfoViewModel.items?.address?.street ?? "") \(userInfoViewModel.items?.address?.suite ?? "") \(userInfoViewModel.items?.address?.city  ?? "") / \(userInfoViewModel.items?.address?.zipcode ?? "")"))
        return cell
    }
}
