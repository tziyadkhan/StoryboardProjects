//
//  MovieInfoViewModel.swift
//  MovieApp
//
//  Created by Ziyadkhan on 14.12.23.
//

import Foundation

class MovieInfoViewModel {
    
    var movieItems = [MovieDetailModel]()
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    var movieID: Int?
    
    private let manager = MovieInfoManager()
    
    init(movieID: Int?) {
        self.movieID = movieID
    }
        
    func getMovieInfoItems() {
        manager.getMovieInfo(endpoint: .movieInfo, movieID: movieID) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.movieItems.append(.init(type: .poster(data.posterPath)))
                self.movieItems.append(.init(type: .title(data.title)))
                self.movieItems.append(.init(type: .info(.init(rating: "\((data.voteAverage?.rounded() ?? 0))", 
                                                               genres: data.genres ?? [], length: "\(data.runtime ?? 0)",
                                                               releaseDate: data.releaseDate, 
                                                               language: data.originalLanguage?.uppercased()))))
                self.movieItems.append(.init(type: .description(data.overview)))
                self.cast()
                self.success?()
            }
        }
        
    }
    
    func cast() {
        manager.getCastInfo(movieID: movieID) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.movieItems.append(.init(type: .cast(data.cast ?? [])))
                self.success?()
            }
        }
    }

}

