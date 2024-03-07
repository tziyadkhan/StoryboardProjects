//
//  CardRegistrationController.swift
//  BankApp
//
//  Created by Ziyadkhan on 16.10.23.
//

import UIKit
import Lottie

class CardRegistrationController: UIViewController {
    
    @IBOutlet weak var cardRegView: LottieAnimationView!
    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardDate: UITextField!
    @IBOutlet weak var cardCVV2: UITextField!
    var users = [User]()
    let helper = UserLoginFileManager()
    let emailSaved = UserDefaults().string(forKey: "email")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Card"
        cardRegView.play()
        cardRegView.loopMode = .autoReverse
        
    }
    
    
    @IBAction func createButton(_ sender: Any) {
        helper.readUserData { UserItem in
            self.users = UserItem
            
            if let index = users.firstIndex(where: {$0.email == emailSaved}) {
                let user = users[index]
                let card = Card(
                    cardName: cardNameTextField.text ?? "",
                    cardNumber: cardNumberTextField.text ?? "",
                    cardDate: cardDate.text ?? "",
                    cardCVC2: cardCVV2.text ?? "",
                    cardBalance: 50.0)
                
                users[index].addCard(card)
                helper.writeUserData(users: users)
                navigationController?.popViewController(animated: true)
                
            }
            
        }
        
    }
}
