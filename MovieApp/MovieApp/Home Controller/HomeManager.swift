//
//  HomeManager.swift
//  MovieApp
//
//  Created by Ziyadkhan on 14.12.23.
//

import Foundation

class HomeManager: MovieListUseCase {
    func getMovieList(endpoint: HomeEndpoint, completion: @escaping ((MovieModel?, String?) -> Void)) {
        NetworkManager.request(model: MovieModel.self, endpoint: endpoint.rawValue) { data, errorMessage in
            if let errorMessage {
                completion(nil, errorMessage.localizedDescription)
            } else if let data {
                completion(data, nil)
            }
        }
    }
}
