//
//  SearchListUseCase.swift
//  MovieApp
//
//  Created by Ziyadkhan on 14.12.23.
//

import Foundation

protocol SearchListUseCase {
    func getSearchItems(endpoint: SearchEndpoint, movieKey: String, completion: @escaping ((MovieModel?, String?) -> Void))
}
