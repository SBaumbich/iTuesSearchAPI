//
//  SongViewModel.swift
//  iTunesSearch
//
//  Created by Scott Baumbich on 4/10/20.
//  Copyright © 2020 Keasbey Nights. All rights reserved.
//

import Foundation

struct SongViewModel {
    let title: String
    let runTime: String
}

extension SongViewModel {
    init(song: Song){
        self.title = song.censoredName
        // Track Time in millaseconds
        let timeInSeconds = song.trackTime/1000
        let minutes = timeInSeconds/60 % 60
        let seconds = timeInSeconds % 60

        self.runTime = "\(minutes):\(seconds)"
        
    }
}
