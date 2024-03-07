//
//  PostsViewModel.swift
//  NetworkURLSession
//
//  Created by Ziyadkhan on 27.11.23.
//

import Foundation

class PostsViewModel {
    
    var items: [Post]?
    let service: NetworkManagerService
    //    let networkManager = NetworkManager()
    init(service: NetworkManagerService) {
        self.service = service
    }
    
    func getPostItems(completion: @escaping () -> Void) {
        service.getObjects(type: [Post].self,
                           urlInput: "posts") { results in
            switch(results) {
            case .success(let post):
                self.items = post
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
