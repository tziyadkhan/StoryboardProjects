//
//  AlbumsViewModel.swift
//  NetworkURLSession
//
//  Created by Ziyadkhan on 28.11.23.
//

import Foundation

class AlbumsViewModel {
    
    let service: NetworkManagerService
    init(service: NetworkManagerService) {
        self.service = service
    }
    var items: [Album]?
    
    func getAlbumObjects(completion: @escaping () -> Void) {
        service.getObjects(type: [Album].self,
                                  urlInput: "albums") { results in
            switch (results) {
            case .success(let albumItems):
                self.items = albumItems
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
