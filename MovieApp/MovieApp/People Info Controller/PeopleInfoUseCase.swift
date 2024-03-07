//
//  PeopleInfoUseCase.swift
//  MovieApp
//
//  Created by Ziyadkhan on 18.12.23.
//

import Foundation

protocol PeopleInfoUseCase {
    func getPeopleInfo(peopleID: Int?, completion: @escaping ((PeopleInfoModel?, String?) -> Void))
}
