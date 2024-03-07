//
//  UsersCollectionCell.swift
//  NetworkURLSession
//
//  Created by Ziyadkhan on 27.11.23.
//

import UIKit

class UsersCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var userFullname: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    func fillCell(fullname: String?, email: String?) {
        userFullname.text = fullname
        userEmail.text = email
    }
}
