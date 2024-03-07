//
//  ProfilePageController.swift
//  BankApp
//
//  Created by Ziyadkhan on 16.10.23.
//

import UIKit
import Lottie
class ProfilePageController: UIViewController {
    @IBOutlet weak var profileView: LottieAnimationView!
    @IBOutlet weak var phonenumberLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    let emailSaved = UserDefaults.standard.string(forKey: "email")
    let helper = UserLoginFileManager()
    var userProfile = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.play()
        profileView.loopMode = .autoReverse
        
        helper.readUserData { userItems in
            self.userProfile = userItems
            
            if let index = userProfile.firstIndex(where: { $0.email == emailSaved }) {
                let user = userProfile[index]
                self.fullnameLabel.text = "Fullname: \(user.fullname ?? "")"
                self.emailLabel.text = "Email: \(user.email ?? "")"
                self.birthdateLabel.text = "Birthdate: \(user.birthdate ?? "")"
                self.phonenumberLabel.text = "Phone number: \(user.phonenumber ?? "")"
            }
        }

    }
    
    @IBAction func logoutButton(_ sender: Any) {
        setRoot()
    }
    

}
extension ProfilePageController {
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.setValue(false, forKey: "loggedIn") // setting the flag
            sceneDelegate.logoutClicked(windowScene: scene)
        }
    }
}

