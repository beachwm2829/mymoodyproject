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

class searchMoodViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
   
    

    
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
    
    var moodcount:String = "0"
    var ACtivitycount:String = "0"
    
    var word: String?
    
    @IBOutlet weak var tableView: UITableView!
    var mvId: String?
    var moodData = [[String:AnyObject]]()
    var pathPhoto :String?
    var Image1 :UIImage?
    var moods = [moodModel]()
    var mood = [String]()
    
    var MoodNameArr = [""]
    
    var MoodArray = [moodModel]()
    var CurrentMoodArray = [moodModel]()
    
    var searchMood = [String]()
    var searching = false
    
    @IBOutlet weak var bt_mood1: UIButton!
    @IBOutlet weak var bt_mood2: UIButton!
    @IBOutlet weak var bt_mood3: UIButton!
    @IBOutlet weak var bt_mood4: UIButton!
    @IBOutlet weak var bt_mood5: UIButton!
     
    @IBOutlet weak var bt_online_shopping: UIButton!
    @IBOutlet weak var bt_entertainment: UIButton!
    @IBOutlet weak var bt_yoga: UIButton!
    @IBOutlet weak var bt_social_media: UIButton!

    
//    @IBOutlet weak var dateseach: UITextField!
    @IBOutlet weak var datePickerSearch: UIDatePicker!
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var moodView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sement: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
//        createDatePicker()
        searchBar.delegate = self
        searchMood = MoodNameArr
        dateView.isHidden = false
        
        datePickerSearch.datePickerMode = .date
        datePickerSearch.preferredDatePickerStyle = .compact
        
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
                    self.MoodArray.append(mood)
//                    print(self.MoodArray)
                    self.CurrentMoodArray = self.MoodArray
                    print("CurrentMoodArray\(self.CurrentMoodArray)")
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
            moodcount = "1"
        }else if sender.tag == 2 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = true
            bt_mood3.isSelected = false
            bt_mood4.isSelected = false
            bt_mood5.isSelected = false
            moodcount = "2"
        }else if sender.tag == 3 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = false
            bt_mood3.isSelected = true
            bt_mood4.isSelected = false
            bt_mood5.isSelected = false
            moodcount = "3"
        }else if sender.tag == 4 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = false
            bt_mood3.isSelected = false
            bt_mood4.isSelected = true
            bt_mood5.isSelected = false
            moodcount = "4"
        }else if sender.tag == 5 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = false
            bt_mood3.isSelected = false
            bt_mood4.isSelected = false
            bt_mood5.isSelected = true
            moodcount = "5"
        }
        CurrentMoodArray = MoodArray.filter({ moodModel -> Bool in
            moodModel.mood == moodcount
        })
        tableView.reloadData()
    }
    func ClearMood() {
        bt_mood1.isSelected = false
        bt_mood2.isSelected = false
        bt_mood3.isSelected = false
        bt_mood4.isSelected = false
        bt_mood5.isSelected = false
    }
    @IBAction func action_Activity(_ sender: UIButton) {
        
        if sender.tag == 1{
            ACtivitycount = "online-shopping"
        }else if(sender.tag == 2){
            ACtivitycount = "entertainment"
        }else if(sender.tag == 3){
            ACtivitycount = "yoga"
        }else if(sender.tag == 4){
            ACtivitycount = "social-media"
        }
        print(ACtivitycount)
        CurrentMoodArray = MoodArray.filter({ moodModel -> Bool in
            moodModel.activity == ACtivitycount
            
        })
        tableView.reloadData()
    }
//    func createDatePicker() {
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//
//        let doneBth = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
//        toolbar.setItems([doneBth], animated: true)
//        dateseach.inputAccessoryView = toolbar
//        dateseach.inputView = datePicker
//
//        datePicker.datePickerMode = .date
//    }
//    @objc func donePressed() {
//        let fotmatter = DateFormatter()
//        fotmatter.dateFormat = "dd-MM-yyyy"
//
//        dateseach.text = fotmatter.string(from: datePicker.date)
//        self.view.endEditing(true)
//
//    }
//    func getDate(){
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en")
//        formatter.dateFormat = "dd-MM-yyyy"
//        let dateString = formatter.string(from: date)
//
//        print("dateseach\(dateseach.text)")
//        let strdatesearch:String = formatter.string(from: dateseach)
//        CurrentMoodArray = MoodArray.filter({ moodModel -> Bool in
//            moodModel.date == strdatesearch
//        })
//        tableView.reloadData()
//    }
//

    @IBAction func btSearch(_ sender: Any) {
        let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let selectedDate = dateFormatter.string(from: datePickerSearch.date)
                print("selectedDate",selectedDate)
                CurrentMoodArray = MoodArray.filter({ moodModel -> Bool in
                    moodModel.date == selectedDate
                })
                tableView.reloadData()
    }
    @IBAction func sement(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("1")
            dateView.isHidden = false
            activityView.isHidden = true
            moodView.isHidden = true
            ClearMood()
        case 1:
            print("2")
            dateView.isHidden = true
            activityView.isHidden = true
            moodView.isHidden = false
            tableView.reloadData()
        case 2:
            print("3")
            dateView.isHidden = true
            moodView.isHidden = true
            activityView.isHidden = false
            tableView.reloadData()
            ClearMood()
        default:
            break
        }
    }


//    override func viewWillAppear(_ animated: Bool) {
//        self.moods.removeAll()
//        self.viewDidLoad()
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrentMoodArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?  seachMoodTableViewCell
                let url = URL(string: "http://project2.cocopatch.com/Moody/\(CurrentMoodArray[indexPath.row].image)")
        //        print("searchMood[indexPath.row]\(searchMood[indexPath.row])")
        cell?.lbNote!.text = CurrentMoodArray[indexPath.row].note
        cell?.lbHastag!.text! = CurrentMoodArray[indexPath.row].hastag
        cell?.lbLocation!.text = CurrentMoodArray[indexPath.row].location
                cell?.img.kf.setImage(with: url)
                cell?.lbDate.text = CurrentMoodArray[indexPath.row].time
                let imgMood = "mood"+CurrentMoodArray[indexPath.row].mood
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
        guard !searchText.isEmpty else {
            CurrentMoodArray = MoodArray
            tableView.reloadData()
            return
        }
        CurrentMoodArray = MoodArray.filter({ moodModel -> Bool in
            moodModel.hastag.contains(searchText.lowercased()) || moodModel.note.contains(searchText.lowercased())
            
        })
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel clicked")
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pm = storyboard?.instantiateViewController(withIdentifier: "popMoodViewController") as? popMoodViewController
        
        let index = MoodArray[indexPath.row]
               let url = URL(string: "http://project2.cocopatch.com/Moody/\(index.image)")
        pm?.note = index.note
        pm?.tag = index.hastag
        pm?.location = index.location
        pm?.image = index.image
        pm?.date = index.time
        var imgMoods = "mood"+index.mood
        pm?.imgMood = UIImage(named: imgMoods)!
        var imgAv = index.activity
        pm?.imgActivi = UIImage(named: imgAv)!
        
        
        
        self.navigationController?.pushViewController(pm!, animated: true)
    }
}
