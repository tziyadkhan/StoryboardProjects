//
//  PeopleInfoViewModel.swift
//  MovieApp
//
//  Created by Ziyadkhan on 18.12.23.
//

import Foundation

class PeopleInfoViewModel {
    
    var peopleInfoItems = [PeopleCast]()
    var sucess: (() -> Void)?
    var error: ((String) -> Void)?
    var peopleID: Int?
    private let manager = PeopleInfoManager()

    
    init(peopleID: Int? = nil) {
        self.peopleID = peopleID
    }
    
    func getPeopleInfoItems() {
        manager.getPeopleInfo(peopleID: peopleID) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.peopleInfoItems = data.cast ?? []
                self.sucess?()
            }
        }
    }
}
