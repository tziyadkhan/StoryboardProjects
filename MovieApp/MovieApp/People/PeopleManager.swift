//
//  PeopleManager.swift
//  MovieApp
//
//  Created by Ziyadkhan on 14.12.23.
//

import Foundation

class PeopleManager: PeopleListUseCase {
    func getPeopleList(pageNumber: Int, completion: @escaping ((People?, String?) -> Void)) {
        let url = PeopleEndpoint.popularPerson.rawValue + "?page=\(pageNumber)"
        NetworkManager.request(model: People.self, endpoint: url) { data, errorMessage in
            if let errorMessage {
                completion(nil, errorMessage.localizedDescription)
            } else if let data {
                completion(data, nil)
            }
        }
    }
}
