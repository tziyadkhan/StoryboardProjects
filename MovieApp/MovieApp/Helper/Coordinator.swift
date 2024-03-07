//
//  Coordinator.swift
//  MovieApp
//
//  Created by Ziyadkhan on 21.12.23.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController {get set}
    
    func start()
}
