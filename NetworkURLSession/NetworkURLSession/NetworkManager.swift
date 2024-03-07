//
//  NetworkManager.swift
//  NetworkURLSession
//
//  Created by Ziyadkhan on 27.11.23.
//

import Foundation

protocol NetworkManagerService {
    func getObjects<T: Codable>(
        type: T.Type,
        urlInput: String?,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

final class NetworkManager: NetworkManagerService {
    static let shared = NetworkManager()
    let baseURL = "https://jsonplaceholder.typicode.com/"
    
    func getObjects<T: Codable>(
        type: T.Type,
        urlInput: String?,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: baseURL + (urlInput ?? "")) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else {
                if let data = data {
                    do {
                        let items = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(items))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
}
