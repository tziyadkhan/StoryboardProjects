//
//  MovieModel.swift
//  MovieApp
//
//  Created by Ziyadkhan on 05.12.23.
//

import Foundation
// MARK: - MovieModel
struct MovieModel: Codable {
    let dates: Dates?
    let page: Int?
    let results: [MovieResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

// MARK: - Result
struct MovieResult: Codable, TopImageBottomLabelProtocol, MovieCellProtocol {
    
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    var titleText: String {
        return title ?? ""
    }
    
    var imagePath: String {
        return backdropPath ?? ""
    }
    var ratingText: String {
        return "\(voteAverage ?? 0)"
    }
    
    var descriptionText: String {
        return overview ?? ""
    }
    
    var movieImage: String {
        return backdropPath ?? ""
    }


    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
