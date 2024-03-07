//
//  RegistrationPageController.swift
//  BankApp
//
//  Created by Ziyadkhan on 16.10.23.
//

import UIKit
import Lottie

class RegistrationPageController: UIViewController {
    
    @IBOutlet weak var registrationView: LottieAnimationView!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    @IBOutlet weak var phonenumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    let helper = UserLoginFileManager()
    var users = [User]()
    var onLogin: ((String?, String?) -> Void)?
    var onUserReg: ((User) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registrationView.play()
        registrationView.loopMode = .loop
        title = "Registration Page"
        
        helper.readUserData { userItems in
            self.users = userItems
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        onLogin?(emailTextField.text, passwordTextField.text)
        let user = User(fullname: fullnameTextField.text ?? "",
                           email: emailTextField.text ?? "",
                           birthdate: birthdateTextField.text ?? "", 
                           phonenumber: phonenumberTextField.text ?? "",
                           password: passwordTextField.text ?? "")
//    cardList: [Card()]
        onUserReg?(user)
        users.append(user)
        helper.writeUserData(users: users)
        navigationController?.popViewController(animated: true)
    }
    
}
