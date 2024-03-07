//
//  CommentsViewController.swift
//  NetworkURLSession
//
//  Created by Ziyadkhan on 27.11.23.
//

import UIKit

class CommentsViewController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var postID: Int?
    let commentViewModel = CommentsViewModel(service: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Comments"
        commentViewModel.getCommentItems(postID: postID) {
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
        }
    }
}

extension CommentsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        commentViewModel.items?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCollectionCell", for: indexPath) as! CommentCollectionCell
        guard let commentItem = commentViewModel.items?[indexPath.item] else{return UICollectionViewCell()}
        cell.fillCell(name: commentItem.name,
                      email: commentItem.email,
                      comment: commentItem.body)
        
        return cell
    }
}
