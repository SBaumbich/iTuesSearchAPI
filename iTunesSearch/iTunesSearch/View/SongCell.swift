//
//  SongCell.swift
//  iTunesSearch
//
//  Created by Scott Baumbich on 4/10/20.
//  Copyright © 2020 Keasbey Nights. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    static let reuseIdentifier = "SongCell"
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songRunTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
