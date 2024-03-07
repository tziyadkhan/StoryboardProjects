//
//  CommentCollectionCell.swift
//  NetworkURLSession
//
//  Created by Ziyadkhan on 27.11.23.
//

import UIKit

class CommentCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userComment: UILabel!
    
    func fillCell(name: String?, email: String?, comment: String?) {
        userName.text = "Name: \(name ?? "")"
        userEmail.text = "Email: \(email ?? "")"
        userComment.text = "Comment: \(comment ?? "")"
    }
    
}
