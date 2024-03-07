//
//  LoginPageController.swift
//  BankApp
//
//  Created by Ziyadkhan on 16.10.23.
//

import UIKit
import Lottie

class LoginPageController: UIViewController {
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var bankLogoAnimation: LottieAnimationView!
    var userLogin = User()
    let helper = UserLoginFileManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bankLogoAnimation.play()
        bankLogoAnimation.loopMode = .autoReverse
        title = "Login Page"

    }
    
    @IBAction func registerButton(_ sender: Any) {
        loginCallBack()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if let loginEmail = loginEmailTextField.text,
           let loginPassword = loginPasswordTextField.text,
           !loginEmail.isEmpty,
           !loginPassword.isEmpty{
            helper.readUserData { users in
                if users.contains(where: {$0.email == loginEmail && $0.password == loginPassword }) {
                    UserDefaults.standard.set(loginEmail, forKey: "email")
                     setRoot()
                    let controller = storyboard?.instantiateViewController(withIdentifier: "HomePageController") as! HomePageController
                    navigationController?.show(controller, sender: nil)
                } else {
                    showAlert(title: "Xəta", message: "Email və ya şifrə düzgün qeyd edilməyib")
                }
            }

        } else {
            showAlert(title: "Xəta", message: "Email və ya şifrə daxil edilməyib")
        }

    }
    
}


// Functions
extension LoginPageController {
    func loginCallBack() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegistrationPageController") as! RegistrationPageController
        controller.onLogin = { email, password in
            self.loginEmailTextField.text = email
            self.loginPasswordTextField.text = password
        }
        controller.onUserReg = { user in
            self.userLogin = user}
        navigationController?.show(controller, sender: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okayButton)
        self.present(alertController, animated: true)
    }
    
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.set(true, forKey: "loggedIn") // setting the flag
            sceneDelegate.loginClicked(windowScene: scene)
        }
    }
}
