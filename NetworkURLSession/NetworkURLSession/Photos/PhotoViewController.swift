//
//  PhotoViewController.swift
//  NetworkURLSession
//
//  Created by Ziyadkhan on 28.11.23.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    
    let photoViewModel = PhotoViewModel(service: NetworkManager())
        
    override func viewDidLoad() {
        super.viewDidLoad()
        photoViewModel.getPhotoObjects {
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
        }
    }
}

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoViewModel.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath) as! PhotoCollectionCell
        cell.imageTitle.text =  photoViewModel.items?[indexPath.item].title
        
        if let imageURLString = photoViewModel.items?[indexPath.item].url,
           let imageURL = URL(string: imageURLString) {
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let imageData = data {
                    DispatchQueue.main.async {
                        cell.image.image = UIImage(data: imageData)
                    }
                }
            }.resume()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SelectedPhotoViewController") as! SelectedPhotoViewController
        guard let selectedItem = photoViewModel.items?[indexPath.row].id else {return}
        controller.selectedPhotoViewModel.selectedItemID = selectedItem
        navigationController?.show(controller, sender: nil)
    }
}


