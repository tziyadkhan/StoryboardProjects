//
//  LoginPageController.swift
//  FoodOrderApp
//
//  Created by Ziyadkhan on 08.10.23.
//

import UIKit

class LoginPageController: UIViewController {
    
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    
    var userLogin = User()
    var userDataHelper = UserLoginFileManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login Page"
    }
    
    @IBAction func registerButton(_ sender: Any) {
        myCallBack()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if let loginEmail = loginEmailTextField.text,
           let loginPassword = loginPasswordTextField.text,
           !loginEmail.isEmpty,
           !loginPassword.isEmpty{
                userDataHelper.readUserData { users in
                    if users.contains(where: {$0.email == loginEmail && $0.password == loginPassword}) {
                        UserDefaults.standard.set(loginEmail, forKey: "email")
                        setRoot()
                        let controller = storyboard?.instantiateViewController(withIdentifier: "HomePageController") as! HomePageController
                        navigationController?.show(controller, sender: nil)
                    }else {
                        showAlert(title: "Xəta", message: "Email və ya şifrə düzgün daxil edilməyib")
                    }
                }
            
        }else {
            showAlert(title: "Xəta", message: "Heç bir məlumat daxil etməmisiniz")
        }
    }
}

//Bosh melumat daxil edilen zaman cixan notification
extension LoginPageController {
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let okayButton = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okayButton)
        self.present(alertController,animated: true)
    }
}
extension LoginPageController {
    
    func myCallBack() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegistrationPageController") as! RegistrationPageController
        controller.onLogin = { email, password in
            self.loginEmailTextField.text = email
            self.loginPasswordTextField.text = password
        }
        
        controller.onUserRegistered = { user in
            self.userLogin = user
        }
        navigationController?.show(controller, sender: nil)
    }
    
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.set(true, forKey: "loggedIn") // Setting the flag
            sceneDelegate.LoginClick(windowScene: scene)
        }
    }
}
