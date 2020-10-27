//
//  seachMoodTableViewCell.swift
//  mymood
//
//  Created by macOS on 10/28/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit

class seachMoodTableViewCell: UITableViewCell {
    @IBOutlet weak var lbNote: UILabel!
    @IBOutlet weak var lbHastag: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbDate: UILabel!
    
    @IBOutlet weak var imgMood: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
