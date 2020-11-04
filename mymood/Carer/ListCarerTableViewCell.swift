//
//  ListCarerTableViewCell.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 31/10/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit

class ListCarerTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var btAdd: UIButton!
    @IBOutlet weak var btDel: UIButton!
    
    var c_id:String?
    var u_id:String?
    
    var actionBlockADD: (() -> Void)? = nil
    var actionBlockDel: (() -> Void)? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btAdd.layer.cornerRadius = 10.0
        btDel.layer.cornerRadius = 10.0
        img.layer.cornerRadius = img.frame.size.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btAdd(_ sender: Any) {
        actionBlockADD?()
    }
    @IBAction func btDel(_ sender: Any) {
        actionBlockDel?()
    }
    
}

