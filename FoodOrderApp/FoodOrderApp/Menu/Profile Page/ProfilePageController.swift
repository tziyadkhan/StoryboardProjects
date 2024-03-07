//
//  ProfilePageController.swift
//  FoodOrderApp
//
//  Created by Ziyadkhan on 09.10.23.
//

import UIKit

class ProfilePageController: UIViewController {
    var userProfile = [User]()
    let helper = UserLoginFileManager()
    let emailSaved = UserDefaults().string(forKey: "email")
    @IBOutlet weak var profileFullnameLabel: UILabel!
    @IBOutlet weak var profileEmailLabel: UILabel!
    @IBOutlet weak var profileBirthdateLabel: UILabel!
    @IBOutlet weak var profilePhonenumberLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile Page"
        
        helper.readUserData { UserItem in
            self.userProfile = UserItem
            
            if let index = userProfile.firstIndex(where: {$0.email == emailSaved}) {
                let user = userProfile[index]
                self.profileEmailLabel.text = "Email: \(user.email ?? "")"
                self.profileFullnameLabel.text = "Fullname: \(user.fullname ?? "")"
                self.profileBirthdateLabel.text = "Birthdate: \(user.birthdate ?? "")"
                self.profilePhonenumberLabel.text = "Phone number: \(user.phoneNumber ?? "")"
            }
        }
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        setRoot()
    }
    
    
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.set(false, forKey: "loggedIn") // Setting the flag
            sceneDelegate.LoggedOutClick(windowScene: scene)
        }
    }
}
