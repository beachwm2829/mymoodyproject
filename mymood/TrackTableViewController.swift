//
//  TrackTableViewController.swift
//  mymood
//
//  Created by macOS on 10/19/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import Kingfisher
import AlamofireObjectMapper

class TrackTableViewController: UITableViewController {
    
    var tackId:String?
    var tkFId:String?
    
    struct TrackModel :Decodable {
        let userId :String
        let tkId :String
        let date :String
        let timetk :String
        let dr_name :String
        let email :String
        let phone :String
        let hospital :String
        let image :String
        let drug :String
        let date_next :String
        let timetk_next :String
        let comment :String
        let status :String
           
       }
    
    var TrackData = [[String:AnyObject]]()
    var TrackUsers = [TrackModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        self.TrackUsers.removeAll()
        self.getTrackUser()
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TrackUsers.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tofromtrack", for: indexPath) as?  TrackTableViewCell
        
        let index = TrackUsers[indexPath.row]
//        let url = URL(string: "http://project2.cocopatch.com/Moody/\(index.image)")
        
        cell?.DateTrack.text = index.date+":"+index.timetk
        cell?.DateTrackNaxt.text = index.date_next+":"+index.timetk_next
        
        if index.status == "1"{
            cell?.imgStatus.image = UIImage(named: "point-yellow")
            
        }else if index.status == "2"{
            cell?.imgStatus.image = UIImage(named: "point-red")
            
        }else if index.status == "3"{
            cell?.imgStatus.image = UIImage(named: "point-green")
            
        }
        
        
        return cell!
    }
    func getTrackUser(){
        
        let url = "http://project2.cocopatch.com/Moody/"
        let param : Parameters = ["u_id":self.tackId! as AnyObject,"mode":"get" as AnyObject]

        AF.request(url+"FromTrack.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
            do {
                //print("do")
                let jsondata = try JSON(data: response.data!)
//                print(jsondata)
                let ListUserArray = jsondata["success"].arrayValue
                for aListUser in ListUserArray {
                    let userId = aListUser["u_id"].stringValue
                    let tkId = aListUser["tf_id"].stringValue
                    let date = aListUser["date"].stringValue
                    let timetk = aListUser["time"].stringValue
                    let dr_name = aListUser["dr_name"].stringValue
                    let email = aListUser["email"].stringValue
                    let phone = aListUser["phone"].stringValue
                    let hospital = aListUser["hospital"].stringValue
                    let image = aListUser["image"].stringValue
                    let drug = aListUser["drug"].stringValue
                    let date_next = aListUser["date_next"].stringValue
                    let timetk_next = aListUser["time_next"].stringValue
                    let comment = aListUser["comment"].stringValue
                    let status = aListUser["status"].stringValue
        
                    let List = TrackModel(userId: userId,tkId: tkId, date: date, timetk: timetk, dr_name: dr_name, email: email, phone: phone, hospital: hospital, image: image, drug: drug, date_next: date_next, timetk_next: timetk_next, comment: comment, status: status)
                    self.TrackUsers.append(List)
//                    print("ListUsers\(self.ListUsers)")
                }
                self.tableView.reloadData()
            }catch{
                self.tableView.reloadData()
            }
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 115
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = TrackUsers[indexPath.row]
        
        tkFId = index.tkId
        print("sickUserId\(tkFId)")
        self.performSegue(withIdentifier: "toFromTrack", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

           if segue.identifier == "toFromTrack"{
                    let popTrackFromViewController = segue.destination as! popTrackFromViewController
                    print(self.tkFId)
            popTrackFromViewController.tkId = self.tkFId
                }
        
    }
    
    
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
