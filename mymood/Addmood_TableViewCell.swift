//
//  Addmood_TableViewCell.swift
//  mymood
//
//  Created by macOS on 8/17/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit

class Addmood_TableViewCell: UITableViewCell {
    @IBOutlet weak var moodcell: UILabel!
       @IBOutlet weak var moodimagecell: UIImageView!
       @IBOutlet weak var notecell: UILabel!
       @IBOutlet weak var imgcell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
