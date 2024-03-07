//
//  LoginPageController.swift
//  CountryAppCV
//
//  Created by Ziyadkhan on 24.09.23.
//

import UIKit

class LoginPageController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if let email = emailTextField.text,
           let password = passwordTextField.text,
           !email.isEmpty,
           !password.isEmpty{
            if password.count >= 5 && password.count <= 10{
                let controller = storyboard?.instantiateViewController(withIdentifier: "CountryListController") as! CountryListController
                navigationController?.show(controller, sender: nil)
            }else{
                warningLabel.text = "Şifrəni səhv yığmısız. Təkrar cəhd edin."
            }
        }else{
            warningLabel.text = "Səhv məlumatı daxil etmisiniz. Təkrar cəhd edin."

        }
            
    }
}
