//
//  Assessment_TableViewCell.swift
//  mymood
//
//  Created by macOS on 10/2/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit

class Assessment_TableViewCell: UITableViewCell {

    @IBOutlet weak var nameAs: UILabel!
    @IBOutlet weak var timeAs: UILabel!
    @IBOutlet weak var dateAs: UILabel!
    @IBOutlet weak var resultAs: UILabel!
    @IBOutlet weak var textResultAs: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
