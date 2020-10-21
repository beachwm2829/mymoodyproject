//
//  TrackTableViewCell.swift
//  mymood
//
//  Created by macOS on 10/20/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var DateTrack: UILabel!
    @IBOutlet weak var DateTrackNaxt: UILabel!
    @IBOutlet weak var imgStatus: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        DateTrack.text = "20 11 2020 10:25"
        DateTrackNaxt.text = "20 3 2021 12:25"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
