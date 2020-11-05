//
//  popMoodViewController.swift
//  mymood
//
//  Created by macOS on 10/13/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class popMoodViewController: UIViewController {
    

    
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var imgMoods: UIImageView!
    @IBOutlet weak var imgActivity: UIImageView!
    @IBOutlet weak var lblocation: UILabel!
    @IBOutlet weak var lbnote: UILabel!
    @IBOutlet weak var lbtag: UILabel!
    @IBOutlet weak var lbdate: UILabel!
    
    
    var date = ""
    var tag = ""
    var note = ""
    var location = ""
    var imgActivi = UIImage()
    var imgMood = UIImage()
    var image = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://project2.cocopatch.com/Moody/\(image)")
        imgview.kf.setImage(with: url)
        imgMoods.image = imgMood
        
        imgActivity.image = imgActivi
        lblocation.text = "\(location)"
        lbnote.text = "\(note)"
        lbtag.text = "\(tag)"
        lbdate.text = "\(date)"
        
        
        
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
