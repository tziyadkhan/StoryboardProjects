//
//  TransferPageController.swift
//  BankApp
//
//  Created by Ziyadkhan on 16.10.23.
//

import UIKit
import Lottie

class TransferPageController: UIViewController {
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var transferView: LottieAnimationView!
    var userCard = [User]()
    let emailSaved = UserDefaults().string(forKey: "email")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transfer"
        transferView.play()
        transferView.loopMode = .autoReverse
    }
    
    @IBAction func transferButton(_ sender: Any) {
        transferMoney()
    }
    
    func transferMoney() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .long
        let dateTimeString = dateFormatter.string(from: date)
        
        if var userInfo = userCard.first,
           var cardInfo = userInfo.cardList?.first {
            var currentBalance: Double = cardInfo.cardBalance ?? 0
            var transferAmount: Double? = Double(amountTextField.text ?? "0")
            if (currentBalance >= transferAmount!) && (cardNumberTextField.text?.count == 16) {
                var calculatedAmount: Double = currentBalance - transferAmount!
                success(title: "Uğurlu Ödəniş", message: """
                        Məbləq: \(transferAmount ?? 0) AZN
                        Kartın nömrəsi: \(cardNumberTextField.text ?? "")
                        Transfer olunan tarix: \(dateTimeString)
                        Balans: \(calculatedAmount) AZN
                        """)
            }else {
                failure(title: "Uğursuz ödəniş",
                        message: """
                                  Balansınızda kifayət qədər pul yoxdur və ya Kart nömrəsini düzgün yazmamısnız.
                                  Balans: \(currentBalance) AZN
                                  """)
            }
        }
        
    }
    
}


extension TransferPageController {
    func success (title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let okayButton = UIAlertAction(title: "Okay",
                                       style: .default) { (_) in
            _ = self.storyboard?.instantiateViewController(withIdentifier: "HomePageController") as! HomePageController
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(okayButton)
        self.present(alertController, animated: true)
    }
    
    // Ugursuz odenish ucun
    func failure(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let okayButton = UIAlertAction(title: "Okay", style: .cancel)
        alertController.addAction(okayButton)
        self.present(alertController, animated: true)
    }
}
