//
//  QueryItemProvider.swift
//  iTunesSearch
//
//  Created by Scott Baumbich on 4/13/20.
//  Copyright © 2020 Keasbey Nights. All rights reserved.
//

import Foundation

protocol QueryItemProvider {
    var queryItem: URLQueryItem {get}
}
