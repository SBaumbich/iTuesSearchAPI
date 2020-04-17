//
//  AlbumCellViewModel.swift
//  iTunesSearch
//
//  Created by Scott Baumbich on 4/9/20.
//  Copyright © 2020 Keasbey Nights. All rights reserved.
//

import Foundation
import UIKit

struct AlbumCellViewModel {
    let artwork: UIImage
    let title: String
    let releaseDate: String
    let genre: String
}

extension AlbumCellViewModel {
    init(album: Album) {
        var artwork = UIImage(named: "AlbumPlaceholder")!
        
        if album.artworkState == .downloaded {
            artwork = album.artwork!
        }
        
        self.artwork = artwork
        self.title = album.censoredName
        self.genre = album.primaryGenre.name
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM dd, yyyy"
        
        self.releaseDate = formatter.string(from: album.releaseDate)
    }
}
