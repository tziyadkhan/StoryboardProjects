//
//  PostTableCell.swift
//  NetworkURLSession
//
//  Created by Ziyadkhan on 28.11.23.
//

import UIKit

class PostTableCell: UITableViewCell {
    
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillCell(title: String?, body: String?) {
        postTitleLabel.text = title
        postBodyLabel.text = body
    }
}
