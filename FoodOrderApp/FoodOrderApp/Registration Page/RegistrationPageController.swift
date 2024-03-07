//
//  RegistrationPageController.swift
//  FoodOrderApp
//
//  Created by Ziyadkhan on 08.10.23.
//

import UIKit

class RegistrationPageController: UIViewController {
    
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    @IBOutlet weak var phonenumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var onLogin: ((String?, String?) -> Void)?
    var onUserRegistered: ((User) -> Void)?
    var helper = UserLoginFileManager()
    var users = [User]() //datani save etmek ucun
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helper.readUserData { userItems in
            self.users = userItems
        }
        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        onLogin?(emailTextField?.text, passwordTextField?.text)
        let user = User(fullname: self.fullnameTextField.text ?? "",
                        email: self.emailTextField.text ?? "",
                        birthdate: self.birthdateTextField.text ?? "",
                        phoneNumber: self.phonenumberTextField.text ?? "",
                        password: self.passwordTextField.text ?? "")
        
        onUserRegistered?(user)
        users.append(user)
        helper.writeUserData(users: users)
        navigationController?.popViewController(animated: true)
    }
}
