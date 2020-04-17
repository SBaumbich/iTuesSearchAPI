//
//  PendingOperation.swift
//  iTunesSearch
//
//  Created by Scott Baumbich on 4/16/20.
//  Copyright © 2020 Keasbey Nights. All rights reserved.
//

import Foundation

class PendingOperation {
    var downloadsInProgress = [IndexPath: Operation]()
    let downloadQueue = OperationQueue()
}
