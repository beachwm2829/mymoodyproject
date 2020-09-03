//
//  Addmood_TableViewController.swift
//  mymood
//
//  Created by macOS on 8/17/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class Addmood_TableViewController: UITableViewController {
    var tdId:String?
    var moodData = [[String:AnyObject]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        height = 200
        return height
    }
//    override func viewWillAppear(_ animated: Bool) {
//        self.getMood()
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//               if segue.identifier == "addMood"{
//                   let NavigationController = segue.destination as! NavigationController
//                   NavigationController.ncId = self.vcId
//       //            let TabbarController = segue.destination as! TabBarController
//       //            TabbarController.tbId = self.vcId
//               }else{}
//           }
//    func getMood(){
//        let url = "https://moodapi.000webhostapp.com/DBMoody/register.php?"
//        let parameter : Parameters = [
//            "id":self.tdId! as AnyObject]
//        AF.request(url, method: .post, parameters: parameter,encoding: JSONEncoding.default, headers: nil).validate().responseJSON{(response)in
//            if((response.value) != nil){
//                let jsondata = JSON(response.value!)
//                if let data = jsondata["mood"].arrayObject{
//                    self.moodData = data as! [[String:AnyObject]]
//                    self.tableView?.reloadData()
//                }
//                if self.moodData.count > 0{
//                    self.tableView?.reloadData()
//                }
//        }
//        }
        
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

//}
