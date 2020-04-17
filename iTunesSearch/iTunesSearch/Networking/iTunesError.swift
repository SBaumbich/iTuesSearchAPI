//
//  iTunesError.swift
//  iTunesSearch
//
//  Created by Scott Baumbich on 4/14/20.
//  Copyright © 2020 Keasbey Nights. All rights reserved.
//

import Foundation

enum ItunesError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonConversionFailure
    case jsonParsingFailure(message: String)
}
