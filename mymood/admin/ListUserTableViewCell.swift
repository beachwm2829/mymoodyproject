//
//  ListUserTableViewCell.swift
//  mymood
//
//  Created by macOS on 10/16/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit

class ListUserTableViewCell: UITableViewCell {

    @IBOutlet weak var lbname: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbuser: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
