//
//  ArtworkDownloader.swift
//  iTunesSearch
//
//  Created by Scott Baumbich on 4/16/20.
//  Copyright © 2020 Keasbey Nights. All rights reserved.
//

import Foundation
import UIKit

class ArtworkDownloader: Operation {
    let album: Album
    
    init(album: Album) {
        self.album = album
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        guard let url = URL(string: album.artworkUrl) else {
            return
        }
        
        guard let imageData = try? Data(contentsOf: url) else {
            return //error with image url
        }
        
        if self.isCancelled {
            return
        }
        
        if imageData.count > 0 {
            //We have bite values so data is valid
            album.artwork = UIImage(data: imageData)
            album.artworkState = .downloaded
        } else {
            album.artworkState = .failed
        }
        
        
    }
}
