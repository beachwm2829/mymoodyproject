//
//  alertMoodTableViewCell.swift
//  mymood
//
//  Created by macOS on 10/31/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit

class alertMoodTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMood: UIImageView!
    @IBOutlet weak var lbfreq: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
