//
//  SearchManager.swift
//  MovieApp
//
//  Created by Ziyadkhan on 14.12.23.
//

import Foundation

class SearchManager:SearchListUseCase {
    
    func getSearchItems(endpoint: SearchEndpoint, movieKey: String, completion: @escaping ((MovieModel?, String?) -> Void)) {
        let param: [String: Any] = ["query": movieKey]
        
        NetworkManager.request(
            model: MovieModel.self,
            endpoint: endpoint.rawValue,
            parameters: param) { data, errorMessage in
            if let errorMessage {
                completion(nil, errorMessage.localizedDescription)
            } else if let data {
                completion(data, nil)
            }
        }
    }
}
