//
//  ListTableTableViewController.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 1/9/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import Kingfisher
import AlamofireObjectMapper

class ListTableTableViewController: UITableViewController {
    
    var ltId :String?
    var moodData = [[String:AnyObject]]()
    var pathPhoto :String?
    var Image1 :UIImage?
//    var moods = [moodModel]()
    var mood = [String]()
    var activity = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        print("ltId = \(ltId!)")
    }
 

//    func getMood(){
//        let url = "https://moodapi.000webhostapp.com/DBMoody/"
//        let param : Parameters = ["u_id":self.ltId! as AnyObject]
//
//        AF.request(url+"getMood.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
//            do {
//                print("do")
//                    let jsondata = try JSON(data: response.data!)
//                print(jsondata)
//                    let moodArray = jsondata["success"].arrayValue
//                    for aMood in moodArray {
//                        let arMood = aMood["mood"].stringValue
//                        let arActivity = aMood["activity"].stringValue
//                        let arLocation = aMood["location"].stringValue
//                        let arNote = aMood["note"].stringValue
//                        let arHastag = aMood["hastag"].stringValue
//                        let arImage = aMood["image"].stringValue
//                        let arTime = aMood["time"].stringValue
//                        let arDate = aMood["date"].stringValue
//
//                        let mood = moodModel(mood: arMood, activity: arActivity, location: arLocation, note: arNote, hastag: arHastag, image: arImage, time: arTime, date: arDate)
//                        self.moods.append(mood)
//
//                    }
//                    self.tableView.reloadData()
//            }catch{
//                print("error")
//            }
//        }
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        //self.getMood()
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListTableViewCell
//        let url = "https://moodapi.000webhostapp.com/DBMoody/"
//        let index = moods[indexPath.row]
//
//        cell!.lbNote.text = "test note"
//        cell!.lbHastag.text = index.hastag
//        cell!.lbLocation.text = index.location
//        var dateString = index.date
//        var timeString = index.time
//        var datatimeString = "\(timeString) \(dateString)"
//        cell!.lbDatatime.text = datatimeString
//        var imgMood = index.mood
//        cell?.imgMood.image = UIImage(named: imgMood)
//        self.pathPhoto = index.image
//        print("table = \(ltId!)")
//
//        KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
//            print(image)
//        })
//        AF.request(url+pathPhoto!).responseImage { response in
//            switch response.result {
//            case .success(let value):
//                print(String(data: value as! Data, encoding: .utf8)!)
//                DispatchQueue.main.async {
//                    cell?.img.image = value
//                    self.Image1 = value
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }

//        let urlimg = URL(string: url+pathPhoto!)
//        cell?.img!.kf.setImage(with: urlimg)

//        return cell!
//    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return moodData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        height = 280
        return height
    }

}

//struct moodModel :Decodable {
//     let mood :String
//     let activity :String
//     let location :String
//     let note :String
//     let hastag :String
//     let image :String
//     let time :String
//     let date :String
// }
