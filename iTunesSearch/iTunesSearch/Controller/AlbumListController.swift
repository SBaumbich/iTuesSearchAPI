//
//  AlbumListController.swift
//  iTunesSearch
//
//  Created by Scott Baumbich on 4/7/20.
//  Copyright © 2020 Keasbey Nights. All rights reserved.
//

import UIKit

class AlbumListController: UITableViewController {

    private struct Constants { static let AlbumCellHeight: CGFloat = 80 }
    
    lazy var dataSource: AlbumListDataSource = {
        return AlbumListDataSource(albums: [], tableView: self.tableView)
    }()
    
    var client = ItunesAPIClient()
    
    var artist : Artist? {
        didSet {
            self.title = artist?.name
            dataSource.update(with: artist!.albums)
            tableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.AlbumCellHeight
    }
    
    // MARK: - Navagation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAlbum" {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let selectedAlbum = dataSource.album(at: selectedIndexPath)
                let albumDetailController = segue.destination as! AlbumDetailController
                client.lookupAlbum(with: selectedAlbum.id) { album, error in
                    albumDetailController.album = album
                    albumDetailController.artworkView.image = selectedAlbum.artwork
                }
            }
        }
    }
}
