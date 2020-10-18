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
import SwiftyJSON

class popListUserViewController: UIViewController {
    

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbname: UILabel!
    @IBOutlet weak var lbsex: UILabel!
    @IBOutlet weak var lbbirth: UILabel!
    @IBOutlet weak var lbadrees: UILabel!
    @IBOutlet weak var lbdisease: UILabel!
    @IBOutlet weak var lbmail: UILabel!
    @IBOutlet weak var lbtel: UILabel!
    
    var popListUserId:String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        let index = ListUsers[]
       
        print(popListUserId)
        let url = "http://project2.cocopatch.com/Moody/"
        let param : Parameters = ["u_id":self.popListUserId as AnyObject]

        AF.request(url+"getListUser.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
            do {
                //print("do")
                let jsondata = try JSON(data: response.data!)
//                print(jsondata)
                let ListUserArray = jsondata["success"].arrayValue
                for aListUser in ListUserArray {
                    let popListUserId = aListUser["u_id"].stringValue
                    self.lbname.text = aListUser["name"].stringValue
                    self.lbsex.text = aListUser["gender"].stringValue
                    self.lbbirth.text = aListUser["birthdate"].stringValue
                    self.lbdisease.text = aListUser["disease"].stringValue
                    self.lbadrees.text = aListUser["adress"].stringValue
                    self.lbmail.text = aListUser["email"].stringValue
                    self.lbtel.text = aListUser["phone"].stringValue
                    let imgprofile = aListUser["img"].stringValue
                    let url = URL(string: "http://project2.cocopatch.com/Moody/\(imgprofile)")
                    self.imgProfile.kf.setImage(with: url)
//                    print("ListUsers\(self.ListUsers)")
                }
            }catch{
            }
        }
    }
    @IBAction func toResultAs(_ sender: Any) {
        self.performSegue(withIdentifier: "toResultAsess", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultAsess"{
            let Assessment = segue.destination as! Assessment_TableViewController
            Assessment.asId = self.popListUserId
        }
    }
//toResultAsess
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
