//
//  ListTableViewCell.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 1/9/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMood: UIImageView!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lbNote: UILabel!
    @IBOutlet weak var lbHastag: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var lbDatatime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
