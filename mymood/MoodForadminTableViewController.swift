//
//  MoodForadminTableViewController.swift
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

struct moodadminModel :Decodable {
       let mid :String
       let mood :String
       let activity :String
       let location :String
       let note :String
       let hastag :String
       let image :String
       let time :String
       let date :String
   }
class MoodForadminTableViewController: UITableViewController {

    var mvId: String?
    var moodData = [[String:AnyObject]]()
    var pathPhoto :String?
    var Image1 :UIImage?
    var moods = [moodadminModel]()
    var mood = [String]()
    var activity = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("mvId =>>>>>\(mvId)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func getDate(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM"
        let dateString = formatter.string(from: date)
//        lbDatemood.text = "TODAY \(dateString)"
    }
    // MARK: - Table view data source
    func getMood(){
        getDate()

        let url = "http://project2.cocopatch.com/Moody/"
        let param : Parameters = ["u_id":self.mvId as AnyObject]

        AF.request(url+"getMood.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
            do {
                //print("do")
                let jsondata = try JSON(data: response.data!)
                //print(jsondata)
                let moodArray = jsondata["success"].arrayValue
                for aMood in moodArray {
                    let arId = aMood["m_id"].stringValue
                    let arMood = aMood["mood"].stringValue
                    let arActivity = aMood["activity"].stringValue
                    let arLocation = aMood["location"].stringValue
                    let arNote = aMood["note"].stringValue
                    let arHastag = aMood["hastag"].stringValue
                    let arImage = aMood["image"].stringValue
                    let arTime = aMood["time"].stringValue
                    let arDate = aMood["date"].stringValue

                    let mood = moodadminModel(mid: arId, mood: arMood, activity: arActivity, location: arLocation, note: arNote, hastag: arHastag, image: arImage, time: arTime, date: arDate)
                    self.moods.append(mood)

                }
                self.tableView.reloadData()
            }catch{
                self.tableView.reloadData()
            }
        }
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moods.count
    }
    override func viewWillAppear(_ animated: Bool) {
        self.moods.removeAll()
        self.getMood()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 110
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "admincell", for: indexPath) as?  MoodTableViewCell
        let index = moods[indexPath.row]
        let url = URL(string: "http://project2.cocopatch.com/Moody/\(index.image)")
        print("this====here")
        cell?.lbNote.text = index.note
        cell?.lbHastag.text = index.hastag
        cell?.lbLocation.text = index.location
        cell?.img.kf.setImage(with: url)
        cell?.lbDate.text = index.time
        var imgMood = "mood"+index.mood
        cell?.imgMood.image = UIImage(named: imgMood)
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pm = storyboard?.instantiateViewController(withIdentifier: "popMoodViewController") as? popMoodViewController
        
        let index = moods[indexPath.row]
               let url = URL(string: "http://project2.cocopatch.com/Moody/\(index.image)")
        pm?.note = index.note
        pm?.tag = index.hastag
        pm?.location = index.location
        pm?.image = index.image
        pm?.date = index.time
        var imgMoods = "mood"+index.mood
        pm?.imgMood = UIImage(named: imgMoods)!
        
        self.navigationController?.pushViewController(pm!, animated: true)
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
