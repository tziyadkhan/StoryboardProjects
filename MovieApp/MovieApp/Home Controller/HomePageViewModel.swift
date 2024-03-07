//
//  HomePageViewModel.swift
//  MovieApp
//
//  Created by Ziyadkhan on 03.12.23.
//

import Foundation
import UIKit

class HomePageViewModel {
    
    var movieItems = [MovieCategoryModel]()
    private let manager = HomeManager()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getItems() {
        getMovieItems(title: "Now Playing", endpoint: .nowPlaying)
        getMovieItems(title: "Popular", endpoint: .popular)
        getMovieItems(title: "Top Rated", endpoint: .topRated)
        getMovieItems(title: "Upcoming", endpoint: .upcoming)
    }
    
    func getMovieItems(title: String, endpoint: HomeEndpoint) {
        manager.getMovieList(endpoint: endpoint) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.movieItems.append(.init(title: title, movies: data.results ?? []))
                self.success?()
            }
        }
    }
}
