//
//  SelectedPhotoViewController.swift
//  NetworkURLSession
//
//  Created by Ziyadkhan on 28.11.23.
//

import UIKit

class SelectedPhotoViewController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    
    let selectedPhotoViewModel = SelectedPhotoViewModel(service: NetworkManager())
//    var selectedItem: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedPhotoViewModel.getPhotoItem(selectedID: selectedPhotoViewModel.selectedItemID) {
            DispatchQueue.main.async {
                self.collection.reloadData()
                self.title = "\(self.selectedPhotoViewModel.items?[(self.selectedPhotoViewModel.selectedItemID ?? 3) - 1].title ?? "bosh")"
            }
        }
    }
}

extension SelectedPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        selectedPhotoViewModel.items?.count ?? 0
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedPhotoCell", for: indexPath) as! SelectedPhotoCell
        if let imageURLString = selectedPhotoViewModel.items?[(selectedPhotoViewModel.selectedItemID ?? 3) - 1].url,
           let imageURL = URL(string: imageURLString) {
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let imageData = data {
                    DispatchQueue.main.async {
                        cell.selectedImage.image = UIImage(data: imageData)
                    }
                }
            }.resume()
        }
        return cell
    }
}


