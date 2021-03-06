//
//  settingTableViewController.swift
//  mymood
//
//  Created by macOS on 9/3/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class settingTableViewController: UITableViewController {

    var stId :String?
    var stTrack :String?
    var stCid :String?
    var stName :String?
    var stSex :String?
    var stBirth :String?
    var stAddress :String?
    var stDisease :String?
    var stMail :String?
    var stTel :String?
    var stImg :String?
    
    @IBOutlet weak var toFromTrackkking: UITableViewCell!
    @IBOutlet weak var btSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getProfile()
    }
    func getProfile(){
        let url = "http://project2.cocopatch.com/Moody/"
        let param : Parameters = ["u_id":self.stId as AnyObject]
        
        AF.request(url+"getProfile.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
            do {
                //print("do")
                let jsondata = try JSON(data: response.data!)
                print("this here popuser")
                let ListUserArray = jsondata["success"].arrayValue
                for aListUser in ListUserArray {
                    self.stTrack = aListUser["trackingstatus"].stringValue
                    self.stCid = aListUser["c_id"].stringValue
                    print("STCID ==== \(self.stCid)")
                }
            }catch{
            }
        }
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("IndexPath: :\(indexPath)")
        if indexPath == [0, 0] {
            performSegue(withIdentifier: "toupdateprofile", sender: self)
        }
        if indexPath == [0, 1] {
            if btSwitch.isOn == true{
                performSegue(withIdentifier: "toSetAlarm", sender: self)
            }
        }
        if indexPath == [1, 0] {
            performSegue(withIdentifier: "toAdvice", sender: self)
        }
        if indexPath == [2, 0] {
            print("STcid = \(self.stCid!)")
            if self.stCid! == "" {
                performSegue(withIdentifier: "toCarer", sender: self)
            }
            else {
                performSegue(withIdentifier: "toCarerDetail", sender: self)
            }
            
        }
        if indexPath == [2, 1] {
            if stTrack == "1" {
                performSegue(withIdentifier: "toFromTrackmb", sender: self)
            }else{
               print("stTrack\(stTrack)")
                
            }
            
        }

        if indexPath == [3, 0] {
            print("exit")
            let actionSheet = UIAlertController(title: nil, message: "ต้องการออกจากระบบหรือไม่?", preferredStyle: UIAlertController.Style.actionSheet)
            let logOutButton = UIAlertAction(title: "ออกจากระบบ", style: UIAlertAction.Style.destructive){(select) in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavigationStart") as! NavigationController
                self.present(vc, animated: true, completion: nil)
            }

            let cancleButton = UIAlertAction(title: "ยกเลิก", style: UIAlertAction.Style.cancel){(select) in}
                actionSheet.addAction(logOutButton)
                actionSheet.addAction(cancleButton)
                self.present(actionSheet, animated: true, completion: nil)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toAdvice"{
            let AdviceTableViewController = segue.destination as! AdviceTableViewController
            AdviceTableViewController.AdvId = stId
        }
        if segue.identifier == "toSetAlarm"{
            let AlarmViewController = segue.destination as! AlarmViewController
            AlarmViewController.alId = stId
        }
        if segue.identifier == "toupdateprofile"{
            let manaProfileViewController = segue.destination as! manaProfileViewController
            manaProfileViewController.rcId = stId
        }
        if segue.identifier == "toCarer"{
            let ListCarerTableViewController = segue.destination as! ListCarerTableViewController
            ListCarerTableViewController.lcId = stId
        }
        if segue.identifier == "toCarerDetail"{
            let CarerViewController = segue.destination as! CarerViewController
            CarerViewController.uvId = stId
            CarerViewController.cvId = stCid
        }

        if stTrack == "1" {
            if segue.identifier == "toFromTrackmb"{
                let trackingmbTableViewController = segue.destination as! trackingmbTableViewController
                trackingmbTableViewController.tackId = stId
                trackingmbTableViewController.tkFId = stTrack
            }
        }else{
            print("stTrack\(stTrack)")
        }
    }
    //manaProfileViewController
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
//
//    if (segue.identifier == "yourSegueIdentifer") {
//        // initialize new view controller and cast it as your view controller
//        var Assessment_TableViewController = segue.destination as! Assessment_TableViewController
//        // your new view controller should have property that will store passed value
//        Assessment_TableViewController.asId = stId
//    }
//    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
