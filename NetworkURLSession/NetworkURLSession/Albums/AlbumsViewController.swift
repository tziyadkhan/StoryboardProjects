//
//  AlbumsViewController.swift
//  NetworkURLSession
//
//  Created by Ziyadkhan on 28.11.23.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    let albumsViewModel = AlbumsViewModel(service: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumsViewModel.getAlbumObjects {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
}

extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albumsViewModel.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableCell", for: indexPath) as! AlbumTableCell
        cell.albumTitleLabel.text = albumsViewModel.items?[indexPath.row].title
        return cell
    }
}
