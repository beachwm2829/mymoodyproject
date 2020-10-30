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

    var AsArray = ["Q2":"แบบคัดกรองโรคซึมเศร้าด้วย 2 คำถาม (2Q)","Q9":"แบบประเมินโรคซึมเศร้าด้วย 9 คำถาม ( 9Q)","Q8":"แบบประเมินการฆ่าตัวตาย (8Q)"]
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
    override func viewWillAppear(_ animated: Bool) {
        AssData.removeAll()
        self.getAssessment()
    }
    // MARK: - Table view data source
    
    @IBAction func toQ2As(_ sender: Any) {
        self.performSegue(withIdentifier: "toAses", sender: self)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssessmentCell", for: indexPath) as? Assessment_TableViewCell
        let index = AssData[indexPath.row]
        print("AssData ----->\(AssData)")
        cell?.nameAs.text = index.nameAs
        cell?.resultAs.text = index.resultAs
        cell?.timeAs.text = index.timeAs
        cell?.dateAs.text = index.dateAs
        if(index.nameAs == "Q2"){
            cell?.lbnote.text = AsArray["Q2"]
        }else if(index.nameAs == "Q9"){
            cell?.lbnote.text = AsArray["Q9"]
        }else if(index.nameAs == "Q8"){
            cell?.lbnote.text = AsArray["Q8"]
        }
        return cell!
        
    }
    
    func getAssessment(){
         let url = "http://project2.cocopatch.com/Moody/"
         let param : Parameters = ["u_id":self.asId! as AnyObject]

         AF.request(url+"getAssessment.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
             do {
//                 print("do")
                 let jsondata = try JSON(data: response.data!)
//                 print(jsondata)
                 let AssessmentArray = jsondata["success"].arrayValue
                 for aAssessment in AssessmentArray {
                     let nameAs = aAssessment["assessment"].stringValue
                     let resultAs = aAssessment["result"].stringValue
                     let dateAs = aAssessment["date"].stringValue
                     let timeAs = aAssessment["time"].stringValue
                     let AsData = AssessmentModel(nameAs: nameAs, timeAs: timeAs, dateAs: dateAs, resultAs: resultAs)
                     self.AssData.append(AsData)
                    print(" self.AssData\( self.AssData)")

                 }
                 self.tableView.reloadData()
             }catch{
                 print("error")
             }
         }
     }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "toAses"{
            let Result_q2_ViewController = segue.destination as! Result_q2_ViewController
            Result_q2_ViewController.q2Id = self.asId
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AssData.count
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
