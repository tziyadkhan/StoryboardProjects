//
//  PeopleInfoCoordinator.swift
//  MovieApp
//
//  Created by Ziyadkhan on 25.12.23.
//

import Foundation
import UIKit

class PeopleInfoCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var peopleID: Int?
    
    init(navigationController: UINavigationController, peopleID: Int? = nil) {
        self.navigationController = navigationController
        self.peopleID = peopleID
    }
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PeopleInfoController") as! PeopleInfoController
        controller.viewModel = PeopleInfoViewModel(peopleID: peopleID)
        controller.hidesBottomBarWhenPushed = true
        navigationController.show(controller, sender: nil)
    }
}
