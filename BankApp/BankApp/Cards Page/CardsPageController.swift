//
//  CardsPageController.swift
//  BankApp
//
//  Created by Ziyadkhan on 16.10.23.
//

import UIKit

class CardsPageController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    var userCard = [Card]()
    var userInfo = [User]()
    let helper = UserLoginFileManager()
    let emailSaved = UserDefaults().string(forKey: "email")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cards"
        table.register(UINib(nibName: "ListCell", bundle: nil),forCellReuseIdentifier: "ListCell")
        print(userCard)
        
    }
    
}
extension CardsPageController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userCard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        cell.listLabel.text = userCard[indexPath.row].cardName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "TransferPageController") as! TransferPageController
        navigationController?.show(controller, sender: nil)
        controller.userCard = userInfo
    }
}
