//
//  MovieInfoManager.swift
//  MovieApp
//
//  Created by Ziyadkhan on 14.12.23.
//

import Foundation

class MovieInfoManager: MovieInfoUseCase {
    
    func getMovieInfo(endpoint: MovieInfoEndpoint, movieID: Int?, completion: @escaping ((MovieInfoModel?, String?) -> Void)) {
        NetworkManager.request(model: MovieInfoModel.self,
                               endpoint: "\(endpoint.rawValue)\(movieID ?? 0)") { data, errorMessage in
            if let errorMessage {
                completion(nil, errorMessage.localizedDescription)
            } else if let data {
                completion(data, nil)
            }
        }
    }
    
    func getCastInfo(movieID: Int?, completion: @escaping ((CastInfoModel?, String?) -> Void)) {
        let url = MovieInfoEndpoint.movieInfo.rawValue + "\(movieID ?? 0)/credits"
                    // movie/787699/credits
        NetworkManager.request(model: CastInfoModel.self,
                               endpoint: url) { data, errorMessage in
            if let errorMessage {
                completion(nil, errorMessage.localizedDescription)
            } else if let data {
                print(url)
                completion(data, nil)
            }
        }
    }
}


