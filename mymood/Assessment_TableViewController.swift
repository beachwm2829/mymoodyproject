//
//  Assessment_TableViewController.swift
//  mymood
//
//  Created by macOS on 10/2/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class Assessment_TableViewController: UITableViewController {
    
    struct AssessmentModel :Decodable {
           let nameAs :String
           let timeAs :String
           let dateAs :String
           let resultAs :String
       }

    var asId: String?
    var AssData = [AssessmentModel]()
    var AsData = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ASSemment**")
        print(asId)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssessmentCell", for: indexPath) as? Assessment_TableViewCell
        let url = "https://moodapi.000webhostapp.com/DBMoody/"
        let index = AssData[indexPath.row]
        
        cell?.nameAs.text = index.nameAs
        cell?.resultAs.text = index.resultAs
        cell?.timeAs.text = index.timeAs
        cell?.dateAs.text = index.dateAs
        
        
        
        return cell!
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getMood()
    }
    func getMood(){
         let url = "https://moodapi.000webhostapp.com/DBMoody/"
         let param : Parameters = ["u_id":self.asId! as AnyObject]

         AF.request(url+"getAssessment.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
             do {
                 //print("do")
                 let jsondata = try JSON(data: response.data!)
                 print(jsondata)
                 let AssessmentArray = jsondata["success"].arrayValue
                 for aAssessment in AssessmentArray {
                     let nameAs = aAssessment["assessment"].stringValue
                     let resultAs = aAssessment["result"].stringValue
                     let dateAs = aAssessment["date"].stringValue
                     let timeAs = aAssessment["time"].stringValue

                     let AsData = AssessmentModel(nameAs: nameAs, timeAs: timeAs, dateAs: dateAs, resultAs: resultAs)
                     self.AssData.append(AsData)

                 }
                 self.tableView.reloadData()
             }catch{
                 print("error")
             }
         }
     }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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