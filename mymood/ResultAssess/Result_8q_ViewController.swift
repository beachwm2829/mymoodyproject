//
//  Result_8q_ViewController.swift
//  myAlamofire
//
//  Created by Manasawee Kaenampornpan on 2/5/2563 BE.
//  Copyright © 2563 iClassroom510-30. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Result_8q_ViewController: UIViewController {

    @IBOutlet weak var btTure_q8_r1: UIButton!
    @IBOutlet weak var btFalse_q8_r1: UIButton!
    
    
    @IBOutlet weak var btTure_q8_r2: UIButton!
    @IBOutlet weak var btFalse_q8_r2: UIButton!
    
    
    @IBOutlet weak var btTure_q8_r3: UIButton!
    @IBOutlet weak var btFalse_q8_r3: UIButton!
    
    
    @IBOutlet weak var btTure_q8_r4: UIButton!
    @IBOutlet weak var btFalse_q8_r4: UIButton!
    
    
    @IBOutlet weak var btTure_q8_r5: UIButton!
    @IBOutlet weak var btFalse_q8_r5: UIButton!
    
    
    @IBOutlet weak var btTure_q8_r6: UIButton!
    @IBOutlet weak var btFalse_q8_r6: UIButton!
    
    
    @IBOutlet weak var btTure_q8_r7: UIButton!
    @IBOutlet weak var btFalse_q8_r7: UIButton!
    
    
    @IBOutlet weak var btTure_q8_r8: UIButton!
    @IBOutlet weak var btFalse_q8_r8: UIButton!
    
    
    var q8Id :String?
    
    var rated = ""
    var assess = "Q8"
    var result_r1 = 0
    var result_r2 = 0
    var result_r3 = 0
    var result_r4 = 0
    var result_r5 = 0
    var result_r6 = 0
    var result_r7 = 0
    var result_r8 = 0
    var result = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btQ8_r1(_ sender: UIButton) {
        if sender.tag == 1 {
            btTure_q8_r1.isSelected = true
            btFalse_q8_r1.isSelected = false
            result_r1 = 1
        }else if sender.tag == 2 {
            btTure_q8_r1.isSelected = false
            btFalse_q8_r1.isSelected = true
            result_r1 = 0
        }
    }
    
    @IBAction func btQ8_r2(_ sender: UIButton) {
        if sender.tag == 1 {
            btTure_q8_r2.isSelected = true
            btFalse_q8_r2.isSelected = false
            result_r2 = 2
        }else if sender.tag == 2 {
            btTure_q8_r2.isSelected = false
            btFalse_q8_r2.isSelected = true
            result_r2 = 0
        }
    }
    
    @IBAction func btQ8_r3(_ sender: UIButton) {
        if sender.tag == 1 {
            btTure_q8_r3.isSelected = true
            btFalse_q8_r3.isSelected = false
            result_r3 = 6
        }else if sender.tag == 2 {
            btTure_q8_r3.isSelected = false
            btFalse_q8_r3.isSelected = true
            result_r3 = 0
        }
    }
    
    @IBAction func btQ8_r4(_ sender: UIButton) {
        if sender.tag == 1 {
            btTure_q8_r4.isSelected = true
            btFalse_q8_r4.isSelected = false
            result_r4 = 8
        }else if sender.tag == 2 {
            btTure_q8_r4.isSelected = false
            btFalse_q8_r4.isSelected = true
            result_r4 = 0
        }
    }
    
    @IBAction func btQ8_r5(_ sender: UIButton) {
        if sender.tag == 1 {
            btTure_q8_r5.isSelected = true
            btFalse_q8_r5.isSelected = false
            result_r5 = 9
        }else if sender.tag == 2 {
            btTure_q8_r5.isSelected = false
            btFalse_q8_r5.isSelected = true
            result_r5 = 0
        }
    }
    
    @IBAction func btQ8_r6(_ sender: UIButton) {
        if sender.tag == 1 {
            btTure_q8_r6.isSelected = true
            btFalse_q8_r6.isSelected = false
            result_r6 = 4
        }else if sender.tag == 2 {
            btTure_q8_r6.isSelected = false
            btFalse_q8_r6.isSelected = true
            result_r6 = 0
        }
    }
    
    @IBAction func btQ8_r7(_ sender: UIButton) {
        if sender.tag == 1 {
            btTure_q8_r7.isSelected = true
            btFalse_q8_r7.isSelected = false
            result_r7 = 10
        }else if sender.tag == 2 {
            btTure_q8_r7.isSelected = false
            btFalse_q8_r7.isSelected = true
            result_r7 = 0
        }
    }
    
    @IBAction func btQ8_r8(_ sender: UIButton) {
        if sender.tag == 1 {
            btTure_q8_r8.isSelected = true
            btFalse_q8_r8.isSelected = false
            result_r8 = 4
        }else if sender.tag == 2 {
            btTure_q8_r8.isSelected = false
            btFalse_q8_r8.isSelected = true
            result_r8 = 0
        }
    }
    
    @IBAction func save(_ sender: Any) {
        result = result_r1 + result_r2 + result_r3 + result_r4 + result_r5 + result_r6 + result_r7 + result_r8
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        let time = "\(hour):\(minutes):\(seconds)"
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = formatter.string(from: date)
        print(dateString)
        
        let url = "http://project2.cocopatch.com/Moody/assessment.php?"
        let param : Parameters = [
            "assess":assess as AnyObject,
            "result":result as AnyObject,
            "time":time as AnyObject,
            "date":dateString as AnyObject,
            "u_id":q8Id as AnyObject
        ]

        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
        switch response.result {
            case .success(_):
                print("success")
                if self.result >= 1 {
                    self.rated = "\"ระดับน้อย\""
                    if self.result >= 9 {
                        self.rated = "\"ระดับปานกลาง\""
                    }else if self.result >= 17 {
                        self.rated = "\"ระดับรุนแรง\""
                    }
                    let alert = UIAlertController(title: "คุณมีแนวโน้มที่จะฆ่าตัวตายในปัจจุบันใน \(self.rated)", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .cancel, handler:{(action) -> Void in
                        self.performSegue(withIdentifier: "toTabbar", sender: self)
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyTabBarController") as! TabBarController
//                        self.present(vc, animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else if self.result == 0 {
                    let alert = UIAlertController(title: "คุณไม่มีแนวโน้มที่จะฆ่าตัวตายในปัจจุบัน", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .cancel, handler:{(action) -> Void in
                        self.performSegue(withIdentifier: "toTabbar", sender: self)
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyTabBarController") as! TabBarController
//                        self.present(vc, animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
            }
            case .failure(_):
                print("fail")
               
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTabbar"{
            let TabbarController = segue.destination as! TabBarController
            TabbarController.tbId = self.q8Id
        }
    }
}
