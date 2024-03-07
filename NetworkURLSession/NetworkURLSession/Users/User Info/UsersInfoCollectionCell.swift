//
//  UsersInfoCollectionCell.swift
//  NetworkURLSession
//
//  Created by Ziyadkhan on 27.11.23.
//

import UIKit

class UsersInfoCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    func fillCell(username: String?, 
                  email: String?,
                  phone: String?,
                  company: String?,
                  address: String?) {
        
        usernameLabel.text = "Username: \(username ?? "")"
        emailLabel.text = "Email: \(email ?? "")"
        phoneLabel.text = "Phone: \(phone ?? "")"
        companyLabel.text = "Company: \(company ?? "")"
        addressLabel.text = "Address: \(address ?? "bosh")"
    }
    
}
