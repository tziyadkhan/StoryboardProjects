//
//  MovieSelectCellDelegate.swift
//  MovieApp
//
//  Created by Ziyadkhan on 18.12.23.
//

import Foundation

protocol MovieSelectCellDelegate {
    func didSelectMovie(at index: Int)
}

protocol DidButtonTappedDelegate {
    func seeAllDelegate(at category: HomeCategory)
}
