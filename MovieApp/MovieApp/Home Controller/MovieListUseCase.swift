//
//  MovieListUseCase.swift
//  MovieApp
//
//  Created by Ziyadkhan on 14.12.23.
//

import Foundation

protocol MovieListUseCase {
    func getMovieList(endpoint: HomeEndpoint, completion: @escaping ((MovieModel?, String?) -> Void))
}
