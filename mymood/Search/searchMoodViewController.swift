//
//  searchMoodViewController.swift
//  mymood
//
//  Created by macOS on 10/28/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import AlamofireObjectMapper

class searchMoodViewController: UIViewController, UISearchBarDelegate {

    
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
    
    var moodcount = 0
    
    var word: String?
    
    @IBOutlet weak var tableView: UITableView!
    var mvId: String?
    var moodData = [[String:AnyObject]]()
    var pathPhoto :String?
    var Image1 :UIImage?
    var moods = [moodModel]()
    var mood = [String]()
    
    var MoodNameArr = [""]
    
    var searchMood = [String]()
    var searching = false
    
    @IBOutlet weak var bt_mood1: UIButton!
    @IBOutlet weak var bt_mood2: UIButton!
    @IBOutlet weak var bt_mood3: UIButton!
    @IBOutlet weak var bt_mood4: UIButton!
    @IBOutlet weak var bt_mood5: UIButton!
     
    @IBOutlet weak var dateseach: UITextField!
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var moodView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sement: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        searchBar.delegate = self
        searchMood = MoodNameArr
        dateView.isHidden = false
        
        let url = "http://project2.cocopatch.com/Moody/"
        let param : Parameters = ["u_id":self.mvId as AnyObject,"mode":"search" as AnyObject]

        AF.request(url+"mood.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
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
                    self.MoodNameArr.append(aMood["note"].stringValue)
                    self.MoodNameArr.append(aMood["hastag"].stringValue)
                    let mood = moodModel(mid: arId, mood: arMood, activity: arActivity, location: arLocation, note: arNote, hastag: arHastag, image: arImage, time: arTime, date: arDate)
                    self.moods.append(mood)
                    print(self.moods)
                }
                self.tableView.reloadData()
            }catch{
                self.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btMoodControl(_ sender: UIButton) {
        if sender.tag == 1 {
            bt_mood1.isSelected = true
            bt_mood2.isSelected = false
            bt_mood3.isSelected = false
            bt_mood4.isSelected = false
            bt_mood5.isSelected = false
            bt_mood5.isSelected = false
            moodcount = 1
        }else if sender.tag == 2 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = true
            
            bt_mood3.isSelected = false
            bt_mood4.isSelected = false
            bt_mood5.isSelected = false
            moodcount = 2
        }else if sender.tag == 3 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = false
            bt_mood3.isSelected = true
            bt_mood4.isSelected = false
            bt_mood5.isSelected = false
            moodcount = 3
        }else if sender.tag == 4 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = false
            bt_mood3.isSelected = false
            bt_mood4.isSelected = true
            bt_mood5.isSelected = false
            moodcount = 4
        }else if sender.tag == 5 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = false
            bt_mood3.isSelected = false
            bt_mood4.isSelected = false
            bt_mood5.isSelected = true
            moodcount = 5
        }
    }
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBth = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBth], animated: true)
        dateseach.inputAccessoryView = toolbar
        dateseach.inputView = datePicker
        
        datePicker.datePickerMode = .date
        
    }
    @objc func donePressed() {
        let fotmatter = DateFormatter()
        fotmatter.dateFormat = "dd-MM-yyyy"
    
        dateseach.text = fotmatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    func getDate(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM"
        let dateString = formatter.string(from: date)
//        lbDatemood.text = "TODAY \(dateString)"
    }
    

    @IBAction func sement(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            print("1")
            dateView.isHidden = false
            activityView.isHidden = true
            moodView.isHidden = true
        case 1:
            print("2")
            dateView.isHidden = true
            activityView.isHidden = true
            moodView.isHidden = false
        case 2:
            print("3")
            dateView.isHidden = true
            moodView.isHidden = true
            activityView.isHidden = false
        default:
            break
        }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.moods.removeAll()
        self.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moods.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?  seachMoodTableViewCell
        let index = moods[indexPath.row]
        let url = URL(string: "http://project2.cocopatch.com/Moody/\(index.image)")
//        print("searchMood[indexPath.row]\(searchMood[indexPath.row])")
        cell?.lbNote.text = searchMood[indexPath.row]
//        cell?.textLabel?.text = searchMood[indexPath.row]
        cell?.lbHastag.text = index.hastag
        cell?.lbLocation.text = index.location
        cell?.img.kf.setImage(with: url)
        cell?.lbDate.text = index.time
        var imgMood = "mood"+index.mood
        cell?.imgMood.image = UIImage(named: imgMood)
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 110
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
            moods.removeAll()
            self.viewDidLoad()
            
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        searchMood = []
        word = searchText
        print("Word :\(word)")
//        print("Name Name ListUser og:\(ListUsers)")
        if searchText == "" {
            searchMood = MoodNameArr
        }else{
            for i in moods{
                let namearr = i.note
                let userarr = i.hastag
//                self.u_id = i.mid
                let finalString = [userarr, namearr].joined(separator: "\t")
                if finalString.lowercased().contains(searchText.lowercased()){
                    searchMood.append(finalString)
                }
                print(i)
            }
        }
        self.tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel clicked")
    }

}
