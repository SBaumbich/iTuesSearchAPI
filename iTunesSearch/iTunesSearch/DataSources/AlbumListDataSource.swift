 //
//  AlbumListDataSource.swift
//  iTunesSearch
//
//  Created by Scott Baumbich on 4/9/20.
//  Copyright © 2020 Keasbey Nights. All rights reserved.
//

import UIKit

 class AlbumListDataSource: NSObject, UITableViewDataSource {
    
    private var albums: [Album]
    let pendingOperations = PendingOperation()
    let tableView: UITableView
    
    init(albums: [Album], tableView: UITableView) {
        self.albums = albums
        self.tableView = tableView
        super.init()
    }

    
    // MARK: - Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumCell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.reuseIdentifier, for: indexPath) as! AlbumCell
        let album = albums[indexPath.row]
        let viewModel = AlbumCellViewModel(album: album)
        
        albumCell.configure(with: viewModel)
        albumCell.accessoryType = .disclosureIndicator
        
        if album.artworkState == .placeHolder {
            downloadArtworkForAlbum(album, atIndexPath: indexPath )
        }
        
        return albumCell
    }
    
    // MARK: - Helper Methods
    
    func album(at indexPath: IndexPath) -> Album {
        return albums[indexPath.row]
    }
    
    func update (with albums: [Album]) {
        self.albums = albums
    }
    
    func downloadArtworkForAlbum(_ album: Album, atIndexPath indexPath: IndexPath) {
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            return // operation is currently processing in the background
        }
        //We do not have an opperation for the album at this index path
        let downloader = ArtworkDownloader(album: album)
        downloader.completionBlock = {
            if downloader .isCancelled {
                return
            }
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
        
    }
}
