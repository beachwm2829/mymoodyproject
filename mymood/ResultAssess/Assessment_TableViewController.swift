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

class Assessment_TableViewController: UITableViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    
    struct AssessmentModel :Decodable {
           let nameAs :String
           let timeAs :String
           let dateAs :String
           let resultAs :String
        let mounth :String
        let year :String
       }

    @IBOutlet weak var datemonthPicker: UIPickerView!
    
    var AsArray = ["Q2":"แบบคัดกรองโรคซึมเศร้าด้วย 2 คำถาม (2Q)","Q9":"แบบประเมินโรคซึมเศร้าด้วย 9 คำถาม ( 9Q)","Q8":"แบบประเมินการฆ่าตัวตาย (8Q)"]
    var months = ["All","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
    var year = [String]()
    var yearArr = [String]()
    var asId: String?
    var AssData = [AssessmentModel]()
    var AsData = [String]()
    var Years = [String]()
    
    var AsessmentArray = [AssessmentModel]()
    var CurrentAsesArray = [AssessmentModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ASSemment**")
        print(asId)
        self.getYesr()
        
//        dateTimePicker.heightA
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return months.count
        }
        return Years.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return months[row]
        }
        return Years[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(months[row])
        if(months[row] == "All"){
            
        }else{
            CurrentAsesArray = AssData.filter({ AssessmentModel -> Bool in
    //            AssessmentModel.year == Years[row] ||
                    AssessmentModel.mounth == months[row]
            })
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AssData.removeAll()
//        yearArr.removeAll()
        self.getAssessment()
        
        datemonthPicker.delegate = self
        datemonthPicker.dataSource = self
        self.Years = Array(Set(yearArr))
        print("Years\(Years)")
        
        
    }
    func getYesr() {
        
    }
    // MARK: - Table view data source
    
    @IBAction func toQ2As(_ sender: Any) {
        self.performSegue(withIdentifier: "toAses", sender: self)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssessmentCell", for: indexPath) as? Assessment_TableViewCell
        let index = CurrentAsesArray[indexPath.row]
        print("AssData ----->\(CurrentAsesArray)")
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
                    var years = ""
                    for item in self.year {
                        var array = item.components(separatedBy: "-")
                            self.yearArr.append(array[0])
                        years = array[0]
                    }
                        var arraym = dateAs.components(separatedBy: "-")
                    var mounths = arraym[1]
                    if(mounths == "01"){mounths = "Jan"}else if(mounths == "02"){mounths = "Feb"}else if(mounths == "03"){mounths = "Mar"}else if(mounths == "04"){mounths = "Apr"}else if(mounths == "05"){mounths = "May"}else if(mounths == "06"){mounths = "Jun"}else if(mounths == "07"){mounths = "Jul"}else if(mounths == "08"){mounths = "Aug"}else if(mounths == "09"){mounths = "Sep"}else if(mounths == "10"){mounths = "Oct"}else if(mounths == "11"){mounths = "Nov"}else if(mounths == "12"){mounths = "Dec"}
                    
//                        years = array[0]
                    
                     
                    let AsData = AssessmentModel(nameAs: nameAs, timeAs: timeAs, dateAs: dateAs, resultAs: resultAs, mounth: mounths , year: years)
                     self.AssData.append(AsData)
                    print(" self.AssData\( self.AssData)")
                    self.year.append(dateAs)
                    
                    self.CurrentAsesArray = self.AssData
                 }
                 self.tableView.reloadData()
             }catch{
                 print("error")
             }
         }
     }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "toAses"{
            if let Result_q2_ViewController = segue.destination as? NavigationController{
                if let ResultQ2 = Result_q2_ViewController.viewControllers.first as? Result_q2_ViewController{
                    ResultQ2.q2Id = self.asId
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CurrentAsesArray.count
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
