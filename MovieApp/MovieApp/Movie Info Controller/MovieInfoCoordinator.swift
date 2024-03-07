//
//  MovieInfoCoordinator.swift
//  MovieApp
//
//  Created by Ziyadkhan on 22.12.23.
//

import Foundation
import UIKit

class MovieInfoCoordinator: Coordinator {
    var navigationController: UINavigationController
    var movieID: Int
    
    init(movieID: Int, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.movieID = movieID
    }
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieInfoController") as! MovieInfoController
//        controller.viewModel? = .init(movieID: movieID)
        controller.viewModel = MovieInfoViewModel(movieID: movieID)
        controller.hidesBottomBarWhenPushed = true
        navigationController.show(controller, sender: nil)
    }
    
    
}
