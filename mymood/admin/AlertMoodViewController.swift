//
//  AlertMoodViewController.swift
//  mymood
//
//  Created by macOS on 10/30/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire

class AlertMoodViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var mood = 0
    var pickercount:String?
    
    @IBOutlet weak var bt_mood1: UIButton!
    @IBOutlet weak var bt_mood2: UIButton!
    @IBOutlet weak var bt_mood3: UIButton!
    @IBOutlet weak var bt_mood4: UIButton!
    @IBOutlet weak var bt_mood5: UIButton!
    
    @IBOutlet weak var picker: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    var AlerMId:String?
    var amId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.picker.delegate = self
        self.picker.dataSource = self
                
                // Input the data into the array
                pickerData = ["1", "2", "3", "4", "5","6","7","8","9","10"]
        // Do any additional setup after loading the view.
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
        print(mood)
        print(pickercount!)
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
                        self.dismiss(animated: true, completion: nil)
                        
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
