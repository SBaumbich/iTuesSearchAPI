//
//  ViewController.swift
//  iTunesSearch
//
//  Created by Scott Baumbich on 4/6/20.
//  Copyright © 2020 Keasbey Nights. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let searchEndpoint = Itunes.search(term: "Taylor Swift", media: .music(entity: .musicArtist, attribute: .artistTerm))
        print(searchEndpoint)
        
        
    }
}

 
