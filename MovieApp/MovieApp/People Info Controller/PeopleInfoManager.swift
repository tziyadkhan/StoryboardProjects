//
//  PeopleInfoManager.swift
//  MovieApp
//
//  Created by Ziyadkhan on 18.12.23.
//

import Foundation

class PeopleInfoManager: PeopleInfoUseCase {
    
    func getPeopleInfo(peopleID: Int?, completion: @escaping ((PeopleInfoModel?, String?) -> Void)) {
        let url = "\(PeopleInfoEndpoint.personInfo.rawValue)\(peopleID ?? 0)/credits"
        NetworkManager.request(model: PeopleInfoModel.self, endpoint: url) { data, errorMessage in
            if let errorMessage {
                completion(nil, errorMessage.localizedDescription)
            } else if let data {
                completion(data, nil)
            }
        }
    }
}
