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



class MoodViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    struct moodModel :Decodable {
           let mood :String
           let activity :String
           let location :String
           let note :String
           let hastag :String
           let image :String
           let time :String
           let date :String
       }
    
    var mvId :String?
    var moodData = [[String:AnyObject]]()
    var pathPhoto :String?
    var Image1 :UIImage?
    var moods = [moodModel]()
    var mood = [String]()
    var activity = [String]()
    var name = ["Stave", "tony", "thor"]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func getMood(){
        let url = "https://moodapi.000webhostapp.com/DBMoody/"
        let param : Parameters = ["u_id":self.mvId! as AnyObject]

        AF.request(url+"getMood.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
            do {
                //print("do")
                let jsondata = try JSON(data: response.data!)
                print(jsondata)
                let moodArray = jsondata["success"].arrayValue
                for aMood in moodArray {
                    let arMood = aMood["mood"].stringValue
                    let arActivity = aMood["activity"].stringValue
                    let arLocation = aMood["location"].stringValue
                    let arNote = aMood["note"].stringValue
                    let arHastag = aMood["hastag"].stringValue
                    let arImage = aMood["image"].stringValue
                    let arTime = aMood["time"].stringValue
                    let arDate = aMood["date"].stringValue

                    let mood = moodModel(mood: arMood, activity: arActivity, location: arLocation, note: arNote, hastag: arHastag, image: arImage, time: arTime, date: arDate)
                    self.moods.append(mood)

                }
                self.tableView.reloadData()
            }catch{
                print("error")
            }
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        self.getMood()
    }
}


extension MoodViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?  MoodTableViewCell
        let index = moods[indexPath.row]
        
        cell?.lbNote.text = index.note
        cell?.lbHastag.text = index.hastag
        cell?.lbLocation.text = index.location
        var dateString = index.date
        var timeString = index.time
        var datatimeString = "\(timeString) \(dateString)"
        cell?.lbDate.text = datatimeString
        var imgMood = "mood"+index.mood
        cell?.imgMood.image = UIImage(named: imgMood)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    
}
