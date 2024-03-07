//
//  SearchCoordinator.swift
//  MovieApp
//
//  Created by Ziyadkhan on 25.12.23.
//

import Foundation
import UIKit

class SearchCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchController") as! SearchController
        navigationController.show(controller, sender: nil)
    }
    
    
}
