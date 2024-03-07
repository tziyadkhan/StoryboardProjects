//
//  PeopleViewModel.swift
//  MovieApp
//
//  Created by Ziyadkhan on 08.12.23.
//

import Foundation

class PeopleViewModel {
    
    var peopleData: People? //2
    var peopleItems = [PeopleResult]()
    private let manager = PeopleManager()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getPeopleItems() {
        manager.getPeopleList(pageNumber: (peopleData?.page ?? 0) + 1) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
//                self.peopleItems = data.results ?? []
                self.peopleData = data
                self.peopleItems.append(contentsOf: data.results ?? [])
                self.success?()
            }
        }
    }
    func pagination(index: Int) {
        if index == peopleItems.count - 1 && (peopleData?.page ?? 0 <= peopleData?.totalPages ?? 0) {
            getPeopleItems()
        }
    }
    
    func reset() {
        peopleData = nil
        peopleItems.removeAll()
    }
}
