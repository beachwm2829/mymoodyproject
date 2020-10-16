//
//  popListUserViewController.swift
//  mymood
//
//  Created by macOS on 10/16/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class popListUserViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbname: UILabel!
    @IBOutlet weak var lbsex: UILabel!
    @IBOutlet weak var lbbirth: UILabel!
    @IBOutlet weak var lbadrees: UILabel!
    @IBOutlet weak var lbdisease: UILabel!
    @IBOutlet weak var lbmail: UILabel!
    @IBOutlet weak var lbtel: UILabel!
    
    var popListUserId = ""
    var name = ""
    var sex = ""
    var birth = ""
    var adress = ""
    var disease = ""
    var tel = ""
    var mail = ""
    var imgListUser = UIImage()
    var image = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://project2.cocopatch.com/Moody/\(image)")
        imgProfile.kf.setImage(with: url)
        lbname.text = "\(name)"
        lbsex.text = "\(sex)"
        lbbirth.text = "\(birth)"
        lbadrees.text = "\(adress)"
        lbdisease.text = "\(disease)"
        lbmail.text = "\(mail)"
        lbtel.text = "\(tel)"
        
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
