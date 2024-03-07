//
//  CommentsViewModel.swift
//  NetworkURLSession
//
//  Created by Ziyadkhan on 27.11.23.
//

import Foundation

class CommentsViewModel {
    
    var items: [Comment]?
    
    let service: NetworkManagerService
    init(service: NetworkManagerService) {
        self.service = service
    }
    var postID: Int?
    
    func getCommentItems(postID: Int?, completion: @escaping () -> Void) {
        service.getObjects(type: [Comment].self,
                           urlInput: "posts/\(postID ?? 0)/comments") { result in
            switch (result) {
            case .success(let comments):
                self.items = comments
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
