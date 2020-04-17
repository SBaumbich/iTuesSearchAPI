//
//  SearchResultsDataSource.swift
//  iTunesSearch
//
//  Created by Scott Baumbich on 4/7/20.
//  Copyright © 2020 Keasbey Nights. All rights reserved.
//

import UIKit

class SearchResultsDataSource: NSObject, UITableViewDataSource {

    private var data = [Artist]()
    
    override init() {
        super.init()
    }

    func update(with artists: [Artist]) {
        data = artists
    }
    
    // MARK: - Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let artist = data[indexPath.row]
        cell.textLabel?.text = artist.name
        return cell
    }
    
    // MARK: - Helper Methods
    
    func artist(at indexPath: IndexPath) -> Artist {
        return data[indexPath.row]
    }
}
