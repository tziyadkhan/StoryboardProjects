//
//  Custom Models.swift
//  MovieApp
//
//  Created by Ziyadkhan on 21.12.23.
//

import Foundation

enum MovieDetailItemType {
    case poster(String?)
    case title(String?)
    case info(MovieInfo)
    case description(String?)
    case cast([CastResult]?)
}

struct MovieDetailModel {
    let type: MovieDetailItemType
//    let data: Any?
}

struct MovieInfo: MovieDetailsCellProtocol {
    
    let rating: String?
    let genres: [Genre]
    let length: String?
    let releaseDate: String?
    let language: String?
    
    var ratingText: String {
        return rating ?? ""
    }
    var lengthText: String {
        return length ?? ""
    }
    var releaseDateText: String {
        return releaseDate ?? ""
    }
    var languageText: String {
        return language ?? ""
    }

}
