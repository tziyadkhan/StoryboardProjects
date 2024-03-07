//
//  MovieInfoUseCase.swift
//  MovieApp
//
//  Created by Ziyadkhan on 18.12.23.
//

import Foundation

protocol MovieInfoUseCase {
    func getMovieInfo(endpoint: MovieInfoEndpoint, movieID: Int?, completion: @escaping ((MovieInfoModel?, String?) -> Void))
}
