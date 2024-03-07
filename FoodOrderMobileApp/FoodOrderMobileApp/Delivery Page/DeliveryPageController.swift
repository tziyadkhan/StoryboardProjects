//
//  DeliveryPageController.swift
//  FoodOrderMobileApp
//
//  Created by Ziyadkhan on 12.11.23.
//

import UIKit
import Lottie

class DeliveryPageController: UIViewController {
    
    @IBOutlet weak var deliveryLottie: LottieAnimationView!
    @IBOutlet weak var progressBarLottie: LottieAnimationView!
    @IBOutlet weak var confettiLottie: LottieAnimationView!
    @IBOutlet weak var deliveredLottie: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lottiesConfig()
    }
    
    func lottiesConfig() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "HomePageController")
        deliveryLottie.play()
        deliveryLottie.loopMode = .loop
        deliveryLottie.layer.cornerRadius = 20
        
        progressBarLottie.loopMode = .playOnce
        progressBarLottie.play { [weak self] _ in
            self?.confettiLottie.loopMode = .playOnce
            self?.confettiLottie.play()
            self?.deliveryLottie.isHidden = true
            self?.deliveredLottie.loopMode = .playOnce
            self?.deliveredLottie.play()
        }
    }
}
