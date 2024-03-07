//
//  PostsViewController.swift
//  NetworkURLSession
//
//  Created by Ziyadkhan on 27.11.23.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    let postViewModel = PostsViewModel(service: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postViewModel.getPostItems {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postViewModel.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "PostTableCell", for: indexPath) as! PostTableCell
        guard let postItem = postViewModel.items?[indexPath.row] else {return UITableViewCell()}
        cell.fillCell(title: postItem.title,
                      body: postItem.body)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        guard let selectedPostID  = postViewModel.items?[indexPath.row].id else {return}
        controller.postID = selectedPostID
        navigationController?.show(controller, sender: nil)
    }
}

