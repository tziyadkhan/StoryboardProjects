//
//  SelectedCategoryViewModel.swift
//  MovieApp
//
//  Created by Ziyadkhan on 18.12.23.
//

import Foundation

class SelectedCategoryViewModel {
    
    var movieItems = [MovieResult]()
    private let manager = SelectedCategoryManager()
    
    var success: (() -> Void)?
    var error: ((String?) -> Void)?
    
    func getItems(selectedCategory: String) {
        manager.getMovieList(endpoint:HomeEndpoint(rawValue: selectedCategory) ?? .nowPlaying) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.movieItems = data.results ?? []
                self.success?()
            }
        }
    }
}
