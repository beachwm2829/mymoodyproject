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
    var statusTrack:Bool = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        let index = ListUsers[]
       
        print(popListUserId)
        let url = "http://project2.cocopatch.com/Moody/"
        let param : Parameters = ["u_id":self.popListUserId as AnyObject]

        AF.request(url+"getProfile.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
            do {
                //print("do")
                let jsondata = try JSON(data: response.data!)
                print("this here popuser")
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
    @IBAction func tograpMood(_ sender: Any) {
        self.performSegue(withIdentifier: "tograpmood", sender: self)
    }
    @IBAction func toResultMood(_ sender: Any) {
        self.performSegue(withIdentifier: "toResultMood", sender: self)
    }
    @IBAction func tocalMood(_ sender: Any) {
        self.performSegue(withIdentifier: "tocalMood", sender: self)
    }
    @IBAction func totrack(_ sender: Any) {
        if statusTrack == true {
            self.performSegue(withIdentifier: "totraking", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultAsess"{
            let Assessment = segue.destination as! Assessment_TableViewController
            Assessment.asId = self.popListUserId
        }
        if segue.identifier == "tograpmood"{
            let ChartView = segue.destination as! ChartViewController
            ChartView.ChartsId = self.popListUserId
        }
        if segue.identifier == "toResultMood"{
            let MoodForadmin = segue.destination as! MoodForadminTableViewController
            MoodForadmin.mvId = self.popListUserId
        }
        if segue.identifier == "tocalMood"{
            let CalendarView = segue.destination as! CalendarViewController
            CalendarView.calId = self.popListUserId
        }
        if segue.identifier == "totraking"{
            let TrackTable = segue.destination as! TrackTableViewController
            TrackTable.tackId = self.popListUserId
        }
    }
//toResultAsess
//tograpmood
//toResultMood
//tocalMood
//totraking
    
    @IBAction func swTracking(_ sender: UISwitch) {
        if sender.isOn == true{
            statusTrack = true
            print(statusTrack)
        }
        if sender.isOn == false{
            statusTrack = false
            print(statusTrack)
        }
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