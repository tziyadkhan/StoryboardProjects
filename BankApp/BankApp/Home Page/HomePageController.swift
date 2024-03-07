//
//  HomePageController.swift
//  BankApp
//
//  Created by Ziyadkhan on 16.10.23.
//

import UIKit

class HomePageController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    var menu = Menu.allCases
    var userHome = [User]()
    let helper = UserLoginFileManager()
    let emailSaved = UserDefaults.standard.string(forKey: "email")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register((UINib(nibName: "ListCell", bundle: nil)), forCellReuseIdentifier: "ListCell")
        title = "Home Page"
        readData()
        print("Test userhome \(userHome)")
    }
    
    
}

extension HomePageController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        cell.listLabel.text = menu[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch menu[indexPath.row] {
        case .profile:
            profile()
        case .transfer:
            transfer()
        case .cards:
            cards()
        }
    }
    
}

extension HomePageController {
    func profile() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ProfilePageController") as! ProfilePageController
        controller.userProfile = userHome
        navigationController?.show(controller, sender: nil)
    }
    
    func transfer() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "TransferPageController") as! TransferPageController
        controller.userCard = userHome
        navigationController?.show(controller, sender: nil)
        
    }
    
    func cards() {
        helper.readUserData { userItems in
            self.userHome = userItems
            if let index = userHome.firstIndex(where: { $0.email == emailSaved }) {
                let user = self.userHome[index]
                if let cardlist = user.cardList, !(user.cardList?.count == nil), !(user.cardList?.isEmpty ?? true) {
                    let controller = storyboard?.instantiateViewController(withIdentifier: "CardsPageController") as! CardsPageController
                    controller.userCard = cardlist
                    controller.userInfo = userHome
                    navigationController?.show(controller, sender: nil)
                } else {
                    let controller = storyboard?.instantiateViewController(withIdentifier: "CardRegistrationController") as! CardRegistrationController
                    navigationController?.show(controller, sender: nil)
                }
            }
        }
    }
    
    func readData() {
        helper.readUserData { userItems in
            self.userHome = userItems
        }
        
    }
}
