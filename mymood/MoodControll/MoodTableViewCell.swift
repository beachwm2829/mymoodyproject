//
//  MoodTableViewCell.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 19/9/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit

class MoodTableViewCell: UITableViewCell {

    @IBOutlet weak var lbNote: UILabel!
    @IBOutlet weak var lbHastag: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbDate: UILabel!
    
    @IBOutlet weak var imgMood: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbNote.numberOfLines = 3
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
