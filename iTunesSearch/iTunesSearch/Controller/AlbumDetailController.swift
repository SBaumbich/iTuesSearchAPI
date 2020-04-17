//
//  AlbumDetailController.swift
//  iTunesSearch
//
//  Created by Scott Baumbich on 4/10/20.
//  Copyright © 2020 Keasbey Nights. All rights reserved.
//

import UIKit

class AlbumDetailController: UITableViewController {

    var album: Album? {
        didSet {
            if let album = album {
                configure(with: album)
                dataSource.update(with: album.songs)
                tableView.reloadData()
            }
        }
    }
    
    var dataSource = AlbumDetailDataSoruce(songs: [])

    
    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumGenreLable: UILabel!
    @IBOutlet weak var albumReleaseDateLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let album = album {
            configure(with: album)
        }
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    func configure(with album: Album) {
        let viewModel = AlbumDetailViewModel(album: album)
        // TODO: - Add imp for artworkView
        albumTitleLabel.text = viewModel.title
        albumGenreLable.text = viewModel.genre
        albumReleaseDateLable.text = viewModel.releaseDate
    }

}
