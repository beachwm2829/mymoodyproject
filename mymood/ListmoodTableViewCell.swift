//
//  ListmoodTableViewCell.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 15/9/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit

class ListmoodTableViewCell: UITableViewCell {

    @IBOutlet weak var lbNote: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
