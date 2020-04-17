//
//  iTunesAPIClient.swift
//  iTunesSearch
//
//  Created by Scott Baumbich on 4/14/20.
//  Copyright © 2020 Keasbey Nights. All rights reserved.
//

import Foundation

class ItunesAPIClient {
    let downloader = JSONDownloader()
    
    func searchForArtist(withTerm term: String, compleation: @escaping ([Artist], ItunesError?) -> Void) {
        let endpoint = Itunes.search(term: term, media: .music(entity: .musicArtist, attribute: .artistTerm))
        
        preformRequest(with: endpoint) { results, error in
            guard let results = results else {
                compleation([], error)
                return
            }
            
            let artists = results.compactMap { Artist(json: $0)}
            compleation(artists, nil)
        }
    }
    
    func lookupArtist(with id: Int, compleation: @escaping (Artist?, ItunesError?) -> Void ) {
        let endpoint = Itunes.lookup(id: id, entity: MusicEntity.album)
        
        preformRequest(with: endpoint) { results, error in
            guard let results = results else {
                compleation(nil, error)
                return
            }
            
            guard let artistInfo = results.first else {
                compleation(nil, .jsonParsingFailure(message: "Results did not contain Artist info"))
                return
            }
            
            guard let artist = Artist(json: artistInfo) else {
                compleation(nil, .jsonParsingFailure(message: "Could not parse Artist info"))
                return
            }
            
            let albumResuts = results[1..<results.count]
            let albums = albumResuts.compactMap {Album(json: $0)}
            artist.albums = albums
            compleation(artist, nil )
        }
    }
    
    func lookupAlbum(with id: Int, compleation: @escaping (Album?, ItunesError?) -> Void ) {
        let endpoint = Itunes.lookup(id: id, entity: MusicEntity.song)
    
        preformRequest(with: endpoint) { results, error in
            guard let results = results else {
                compleation(nil, error)
                return
            }
            
            guard let albumInfo = results.first else {
                compleation(nil, .jsonParsingFailure(message: "Results did not contain album info"))
                return
            }
                
            guard let album = Album(json: albumInfo) else {
                compleation(nil, .jsonParsingFailure(message: "Could not parse album info"))
                return
            }
            
            let songResuts = results[1..<results.count]
            let songs = songResuts.compactMap {Song(json: $0)}
            
            album.songs = songs
            compleation(album, nil )
        }
    }
        
    typealias Results = [[String : Any]]
    private func preformRequest(with endpoint: Endpoint, compleation: @escaping (Results?, ItunesError?) -> Void) {
        
        let task = downloader.jsonTask(with: endpoint.request) { json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    compleation(nil, error)
                    return
                }
                
                guard let results = json["results"] as? [[String: Any]] else {
                    compleation(nil, .jsonParsingFailure(message: "JSON does not contain results"))
                    return
                }
                
                compleation(results, nil)
            }
        }
        task.resume()
    }
}
