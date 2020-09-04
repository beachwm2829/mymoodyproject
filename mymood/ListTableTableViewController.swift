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

class ListTableTableViewController: UITableViewController {
    
    var ltId :String?
    var moodData = [[String:AnyObject]]()
    var pathPhoto :String?
    var Image1 :UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ltId = \(ltId!)")
    }

    func getMood(){
        let url = "https://moodapi.000webhostapp.com/DBMoody/"
        let param : [String:AnyObject] = ["u_id":ltId! as AnyObject]

        AF.request(url+"getMood.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                print(String(data: value as! Data, encoding: .utf8)!)
                if(value != nil){
                    let jsondata = JSON(value)
                    if let data = jsondata["mood"].arrayObject {
                        self.moodData = data as! [[String:AnyObject]]
                        self.tableView?.reloadData()
                    }
                    if self.moodData.count > 0 {
                        self.tableView?.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getMood()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListTableViewCell
        let url = "https://moodapi.000webhostapp.com/DBMoody/"
        let index = moodData[indexPath.row]
        
        cell?.lbNote.text = index["note"] as? String
        cell?.lbHastag.text = index["hastag"] as? String
        cell?.lbLocation.text = index["location"] as? String
        var dateString = index["date"] as? String
        var timeString = index["time"] as? String
        var datatimeString = "\(timeString) \(dateString)"
        cell?.lbDatatime.text = datatimeString
        var imgMood = index["mood"] as? String
        cell?.imgMood.image = UIImage(named: imgMood!)
        self.pathPhoto = index["image"] as? String
        
        AF.request(url+pathPhoto!).responseImage { response in
            switch response.result {
            case .success(let value):
                print(String(data: value as! Data, encoding: .utf8)!)
                DispatchQueue.main.async {
                    cell?.img.image = value
                    self.Image1 = value
                }
            case .failure(let error):
                print(error)
            }
        }
        
        return cell!
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return moodData.count
    }

}
