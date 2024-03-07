//
//  NetworkHelper.swift
//  MovieApp
//
//  Created by Ziyadkhan on 07.12.23.
//

import Foundation
import Alamofire

class NetworkHelper {
    static let headers: HTTPHeaders = ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOWMwM2ZjODc3ZmY2ZjQyOTg4ZDBjNjAyMzhmYTczMCIsInN1YiI6IjY1NmFlZmY0NjUxN2Q2MDBjYzQxMTc0NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.aztmmR3xws83nhTheWTgz69Jf-qtc5VR3GVPxTgDEu0"]
    
    static let baseURL = "https://api.themoviedb.org/3/"
}
