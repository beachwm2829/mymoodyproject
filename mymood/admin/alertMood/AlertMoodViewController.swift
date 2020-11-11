//
//  AlertMoodViewController.swift
//  mymood
//
//  Created by macOS on 10/30/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import Kingfisher
import AlamofireObjectMapper

class AlertMoodViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate,UITableViewDataSource {

    
    
    struct AlertMoodModel :Decodable {
        let u_id :String
        let amount :String
        let value :String
        let arm_id :String
       }

    var mood = 0
    var pickercount:String?
    
    @IBOutlet weak var bt_mood1: UIButton!
    @IBOutlet weak var bt_mood2: UIButton!
    @IBOutlet weak var bt_mood3: UIButton!
    @IBOutlet weak var bt_mood4: UIButton!
    @IBOutlet weak var bt_mood5: UIButton!
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var tableView: UITableView!
    var pickerData: [String] = [String]()
    
    var AlerMId:String?
    var amId:String?
    
    var AlertMoodData = [[String:AnyObject]]()
    var AlertMoods = [AlertMoodModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.picker.delegate = self
        self.picker.dataSource = self
                
        // Input the data into the array
        pickerData = ["1", "2", "3", "4", "5","6","7","8","9","10"]
        // Do any additional setup after loading the view.
        
        let url = "http://project2.cocopatch.com/Moody/"
        let param : Parameters = ["u_id":self.AlerMId! as AnyObject,"mode":"selete" as AnyObject]

        AF.request(url+"resultmood.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
            do {
                //print("do")
                let jsondata = try JSON(data: response.data!)
//                print(jsondata)
                let ListUserArray = jsondata["success"].arrayValue
                for aListUser in ListUserArray {
                    let u_id = aListUser["u_id"].stringValue
                    let amount = aListUser["amount"].stringValue
                    let value = aListUser["value_mood"].stringValue
                    let arm_id = aListUser["arm_id"].stringValue
                   
                    let List = AlertMoodModel(u_id:u_id,amount:amount,value:value,arm_id:arm_id)
                    self.AlertMoods.append(List)
                    print(self.AlertMoods)
//                    print("ListUsers\(self.ListUsers)")
                }
                self.tableView.reloadData()
            }catch{
                self.tableView.reloadData()
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlertMoods.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alerMoodcell", for: indexPath) as?  alertMoodTableViewCell
        let index = AlertMoods[indexPath.row]
      
        cell?.lbfreq.text = index.amount
        
        if (index.value == "1") {
            cell?.imgMood.image = UIImage(named: "mood1")
        }else if (index.value == "2") {
            cell?.imgMood.image = UIImage(named: "mood2")
        }else if (index.value == "3") {
            cell?.imgMood.image = UIImage(named: "mood3")
        }else if (index.value == "4") {
            cell?.imgMood.image = UIImage(named: "mood4")
        }else if (index.value == "5") {
            cell?.imgMood.image = UIImage(named: "mood5")
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 66
    }
    @IBAction func btMoodControl(_ sender: UIButton) {
        if sender.tag == 1 {
            bt_mood1.isSelected = true
            bt_mood2.isSelected = false
            bt_mood3.isSelected = false
            bt_mood4.isSelected = false
            bt_mood5.isSelected = false
            mood = 1
        }else if sender.tag == 2 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = true
            bt_mood3.isSelected = false
            bt_mood4.isSelected = false
            bt_mood5.isSelected = false
            mood = 2
        }else if sender.tag == 3 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = false
            bt_mood3.isSelected = true
            bt_mood4.isSelected = false
            bt_mood5.isSelected = false
            mood = 3
        }else if sender.tag == 4 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = false
            bt_mood3.isSelected = false
            bt_mood4.isSelected = true
            bt_mood5.isSelected = false
            mood = 4
        }else if sender.tag == 5 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = false
            bt_mood3.isSelected = false
            bt_mood4.isSelected = false
            bt_mood5.isSelected = true
            mood = 5
        }
    }
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickercount = pickerData[row]
            return pickerData[row]
        }
    @IBAction func btsave(_ sender: Any) {
        if mood == 0 {
            let alertController = UIAlertController(title: "เลือกอารมณ์", message: "กรุณาเลือกอารมณ์ก่อนบันทึก", preferredStyle: UIAlertController.Style.alert)
            let DestructiveAction = UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                print("Settings")
            }

            alertController.addAction(DestructiveAction)

            self.present(alertController, animated: true, completion: nil)
        }else {
            let url = "http://project2.cocopatch.com/Moody/resultmood.php?"
            let param : Parameters = [
                "amount":pickercount! as AnyObject,
                "mood":mood as AnyObject,
                "u_id":AlerMId! as AnyObject,
                "c_id":amId! as AnyObject,
                "mode":"insert" as AnyObject
            ]

            AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
                switch response.result {
                    case .success(_):
                        let alert = UIAlertController(title: "เพิ่มสถานะวิกฤตเรียบร้อย", message: nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "ตกลง", style: .cancel, handler:{(action) -> Void in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    case .failure(_):
                        let alert = UIAlertController(title: "ข้อผิดพลาดเซิร์ฟเวอร์", message: nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "ลองอีกครั้ง", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let Alert = AlertMoods[indexPath.row]
            
            let url = "http://project2.cocopatch.com/Moody/"
            let param : Parameters = [
                "arm_id":Alert.arm_id as AnyObject
            ]
            AF.request(url+"deleteAlert.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil)
            AlertMoods.removeAll()
            viewDidLoad()
            self.tableView.reloadData()
            
        }
    }
}
