//
//  ImageExtension.swift
//  MovieApp
//
//  Created by Ziyadkhan on 05.12.23.
//

import Foundation
import UIKit
import Alamofire
import SDWebImage

extension UIImageView {
    func showImage(imageURL: String?) {
        self.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original/\(imageURL ?? "")"))
    }
}

