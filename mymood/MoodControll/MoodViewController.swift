//
//  MoodViewController.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 19/9/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import Kingfisher
import AlamofireObjectMapper

struct moodModel :Decodable {
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


class MoodViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lbDatemood: UILabel!
    
    var mvId: String?
    var moodData = [[String:AnyObject]]()
    var pathPhoto :String?
    var Image1 :UIImage?
    var moods = [moodModel]()
    var mood = [String]()
    var activity = [String]()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        print(mvId)
    }
    @IBAction func btAddmood(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddmood", sender: self)
    }
    
    @IBAction func btsearchMood(_ sender: Any) {
        self.performSegue(withIdentifier: "tosearchMood", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddmood"{
            let AddmoodViewcontroller = segue.destination as! Addmood_ViewController
            AddmoodViewcontroller.amId = self.mvId
        }
        if segue.identifier == "tosearchMood"{
            let searchMoodViewController = segue.destination as! searchMoodViewController
            searchMoodViewController.mvId = self.mvId
        }
    }
    //tosearchMood
    func getDate(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM"
        let dateString = formatter.string(from: date)
        lbDatemood.text = "TODAY \(dateString)"
    }
    
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

                    let mood = moodModel(mid: arId, mood: arMood, activity: arActivity, location: arLocation, note: arNote, hastag: arHastag, image: arImage, time: arTime, date: arDate)
                    self.moods.append(mood)
                    print(self.moods)
                }
                self.tableView.reloadData()
            }catch{
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        var imgAv = index.activity
        if (imgAv == "") {
            pm?.imgActivi = UIImage(named: "social")!
        }else{
            pm?.imgActivi = UIImage(named: imgAv)!
        }
        

        self.navigationController?.pushViewController(pm!, animated: true)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        self.moods.removeAll()
        self.getMood()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?  MoodTableViewCell
        let index = moods[indexPath.row]
        let url = URL(string: "http://project2.cocopatch.com/Moody/\(index.image)")
        
        cell?.lbNote.text = index.note
        cell?.lbHastag.text = index.hastag
        cell?.lbLocation.text = index.location
        cell?.img.kf.setImage(with: url)
        cell?.lbDate.text = index.time
        var imgMood = "mood"+index.mood
        cell?.imgMood.image = UIImage(named: imgMood)
        
        if (index.activity == "") {
            cell?.imgActivity.image = UIImage(named: "social")
        }else if (index.activity == "social-media") {
            cell?.imgActivity.image = UIImage(named: "social-media")
        }else if (index.activity == "yoga"){
            cell?.imgActivity.image = UIImage(named: "yoga")
        }else if (index.activity == "online-shopping"){
            cell?.imgActivity.image = UIImage(named: "online-shopping")
        }else if (index.activity == "entertainment"){
            cell?.imgActivity.image = UIImage(named: "entertainment")
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 126
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let mood = moods[indexPath.row]
            var mode = "delete"
            let url = "http://project2.cocopatch.com/Moody/"
            let param : Parameters = [
                "m_id":mood.mid as AnyObject,
                "mode":mode as AnyObject
            ]
            AF.request(url+"mood.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil)
            self.moods.removeAll()
//            print("self.moods\(self.moods)")
            self.getMood()
        }
        self.tableView.reloadData()
    }

}
