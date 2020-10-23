//
//  Result_q9_ViewController.swift
//  myAlamofire
//
//  Created by Manasawee Kaenampornpan on 2/5/2563 BE.
//  Copyright © 2563 iClassroom510-30. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Result_q9_ViewController: UIViewController {

    @IBOutlet weak var bt1_q9_r1: UIButton!
    @IBOutlet weak var bt2_q9_r1: UIButton!
    @IBOutlet weak var bt3_q9_r1: UIButton!
    @IBOutlet weak var bt4_q9_r1: UIButton!
    
    @IBOutlet weak var bt1_q9_r2: UIButton!
    @IBOutlet weak var bt2_q9_r2: UIButton!
    @IBOutlet weak var bt3_q9_r2: UIButton!
    @IBOutlet weak var bt4_q9_r2: UIButton!
    
    @IBOutlet weak var bt1_q9_r3: UIButton!
    @IBOutlet weak var bt2_q9_r3: UIButton!
    @IBOutlet weak var bt3_q9_r3: UIButton!
    @IBOutlet weak var bt4_q9_r3: UIButton!
    
    @IBOutlet weak var bt1_q9_r4: UIButton!
    @IBOutlet weak var bt2_q9_r4: UIButton!
    @IBOutlet weak var bt3_q9_r4: UIButton!
    @IBOutlet weak var bt4_q9_r4: UIButton!
    
    @IBOutlet weak var bt1_q9_r5: UIButton!
    @IBOutlet weak var bt2_q9_r5: UIButton!
    @IBOutlet weak var bt3_q9_r5: UIButton!
    @IBOutlet weak var bt4_q9_r5: UIButton!
    
    @IBOutlet weak var bt1_q9_r6: UIButton!
    @IBOutlet weak var bt2_q9_r6: UIButton!
    @IBOutlet weak var bt3_q9_r6: UIButton!
    @IBOutlet weak var bt4_q9_r6: UIButton!
    
    @IBOutlet weak var bt1_q9_r7: UIButton!
    @IBOutlet weak var bt2_q9_r7: UIButton!
    @IBOutlet weak var bt3_q9_r7: UIButton!
    @IBOutlet weak var bt4_q9_r7: UIButton!
    
    @IBOutlet weak var bt1_q9_r8: UIButton!
    @IBOutlet weak var bt2_q9_r8: UIButton!
    @IBOutlet weak var bt3_q9_r8: UIButton!
    @IBOutlet weak var bt4_q9_r8: UIButton!
    
    @IBOutlet weak var bt1_q9_r9: UIButton!
    @IBOutlet weak var bt2_q9_r9: UIButton!
    @IBOutlet weak var bt3_q9_r9: UIButton!
    @IBOutlet weak var bt4_q9_r9: UIButton!
    
    var q9Id :String?
    
    var rated = ""
    var assess = "Q9"
    var result_r1 = 0
    var result_r2 = 0
    var result_r3 = 0
    var result_r4 = 0
    var result_r5 = 0
    var result_r6 = 0
    var result_r7 = 0
    var result_r8 = 0
    var result_r9 = 0
    var result = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btQ9_r1(_ sender: UIButton) {
        if sender.tag == 1 {
            bt1_q9_r1.isSelected = true
            bt2_q9_r1.isSelected = false
            bt3_q9_r1.isSelected = false
            bt4_q9_r1.isSelected = false
            result_r1 = 1
        }else if sender.tag == 2 {
            bt1_q9_r1.isSelected = false
            bt2_q9_r1.isSelected = true
            bt3_q9_r1.isSelected = false
            bt4_q9_r1.isSelected = false
            result_r1 = 2
        }else if sender.tag == 3 {
            bt1_q9_r1.isSelected = false
            bt2_q9_r1.isSelected = false
            bt3_q9_r1.isSelected = true
            bt4_q9_r1.isSelected = false
            result_r1 = 3
        }else if sender.tag == 4 {
            bt1_q9_r1.isSelected = false
            bt2_q9_r1.isSelected = false
            bt3_q9_r1.isSelected = false
            bt4_q9_r1.isSelected = true
            result_r1 = 4
        }
    }
    
    @IBAction func btQ9_r2(_ sender: UIButton) {
        if sender.tag == 1 {
            bt1_q9_r2.isSelected = true
            bt2_q9_r2.isSelected = false
            bt3_q9_r2.isSelected = false
            bt4_q9_r2.isSelected = false
            result_r2 = 1
        }else if sender.tag == 2 {
            bt1_q9_r2.isSelected = false
            bt2_q9_r2.isSelected = true
            bt3_q9_r2.isSelected = false
            bt4_q9_r2.isSelected = false
            result_r2 = 2
        }else if sender.tag == 3 {
            bt1_q9_r2.isSelected = false
            bt2_q9_r2.isSelected = false
            bt3_q9_r2.isSelected = true
            bt4_q9_r2.isSelected = false
            result_r2 = 3
        }else if sender.tag == 4 {
            bt1_q9_r2.isSelected = false
            bt2_q9_r2.isSelected = false
            bt3_q9_r2.isSelected = false
            bt4_q9_r2.isSelected = true
            result_r2 = 4
        }
    }
    
    @IBAction func btQ9_r3(_ sender: UIButton) {
        if sender.tag == 1 {
            bt1_q9_r3.isSelected = true
            bt2_q9_r3.isSelected = false
            bt3_q9_r3.isSelected = false
            bt4_q9_r3.isSelected = false
            result_r3 = 1
        }else if sender.tag == 2 {
            bt1_q9_r3.isSelected = false
            bt2_q9_r3.isSelected = true
            bt3_q9_r3.isSelected = false
            bt4_q9_r3.isSelected = false
            result_r3 = 2
        }else if sender.tag == 3 {
            bt1_q9_r3.isSelected = false
            bt2_q9_r3.isSelected = false
            bt3_q9_r3.isSelected = true
            bt4_q9_r3.isSelected = false
            result_r3 = 3
        }else if sender.tag == 4 {
            bt1_q9_r3.isSelected = false
            bt2_q9_r3.isSelected = false
            bt3_q9_r3.isSelected = false
            bt4_q9_r3.isSelected = true
            result_r3 = 4
        }
    }
    
    @IBAction func btQ9_r4(_ sender: UIButton) {
        if sender.tag == 1 {
            bt1_q9_r4.isSelected = true
            bt2_q9_r4.isSelected = false
            bt3_q9_r4.isSelected = false
            bt4_q9_r4.isSelected = false
            result_r4 = 1
        }else if sender.tag == 2 {
            bt1_q9_r4.isSelected = false
            bt2_q9_r4.isSelected = true
            bt3_q9_r4.isSelected = false
            bt4_q9_r4.isSelected = false
            result_r4 = 2
        }else if sender.tag == 3 {
            bt1_q9_r4.isSelected = false
            bt2_q9_r4.isSelected = false
            bt3_q9_r4.isSelected = true
            bt4_q9_r4.isSelected = false
            result_r4 = 3
        }else if sender.tag == 4 {
            bt1_q9_r4.isSelected = false
            bt2_q9_r4.isSelected = false
            bt3_q9_r4.isSelected = false
            bt4_q9_r4.isSelected = true
            result_r4 = 4
        }
    }
    
    @IBAction func btQ9_r5(_ sender: UIButton) {
        if sender.tag == 1 {
            bt1_q9_r5.isSelected = true
            bt2_q9_r5.isSelected = false
            bt3_q9_r5.isSelected = false
            bt4_q9_r5.isSelected = false
            result_r5 = 1
        }else if sender.tag == 2 {
            bt1_q9_r5.isSelected = false
            bt2_q9_r5.isSelected = true
            bt3_q9_r5.isSelected = false
            bt4_q9_r5.isSelected = false
            result_r5 = 2
        }else if sender.tag == 3 {
            bt1_q9_r5.isSelected = false
            bt2_q9_r5.isSelected = false
            bt3_q9_r5.isSelected = true
            bt4_q9_r5.isSelected = false
            result_r5 = 3
        }else if sender.tag == 4 {
            bt1_q9_r5.isSelected = false
            bt2_q9_r5.isSelected = false
            bt3_q9_r5.isSelected = false
            bt4_q9_r5.isSelected = true
            result_r5 = 4
        }
    }
    
    @IBAction func btQ9_r6(_ sender: UIButton) {
        if sender.tag == 1 {
            bt1_q9_r6.isSelected = true
            bt2_q9_r6.isSelected = false
            bt3_q9_r6.isSelected = false
            bt4_q9_r6.isSelected = false
            result_r6 = 1
        }else if sender.tag == 2 {
            bt1_q9_r6.isSelected = false
            bt2_q9_r6.isSelected = true
            bt3_q9_r6.isSelected = false
            bt4_q9_r6.isSelected = false
            result_r6 = 2
        }else if sender.tag == 3 {
            bt1_q9_r6.isSelected = false
            bt2_q9_r6.isSelected = false
            bt3_q9_r6.isSelected = true
            bt4_q9_r6.isSelected = false
            result_r6 = 3
        }else if sender.tag == 4 {
            bt1_q9_r6.isSelected = false
            bt2_q9_r6.isSelected = false
            bt3_q9_r6.isSelected = false
            bt4_q9_r6.isSelected = true
            result_r6 = 4
        }
    }
    
    @IBAction func btQ9_r7(_ sender: UIButton) {
        if sender.tag == 1 {
            bt1_q9_r7.isSelected = true
            bt2_q9_r7.isSelected = false
            bt3_q9_r7.isSelected = false
            bt4_q9_r7.isSelected = false
            result_r7 = 1
        }else if sender.tag == 2 {
            bt1_q9_r7.isSelected = false
            bt2_q9_r7.isSelected = true
            bt3_q9_r7.isSelected = false
            bt4_q9_r7.isSelected = false
            result_r7 = 2
        }else if sender.tag == 3 {
            bt1_q9_r7.isSelected = false
            bt2_q9_r7.isSelected = false
            bt3_q9_r7.isSelected = true
            bt4_q9_r7.isSelected = false
            result_r7 = 3
        }else if sender.tag == 4 {
            bt1_q9_r7.isSelected = false
            bt2_q9_r7.isSelected = false
            bt3_q9_r7.isSelected = false
            bt4_q9_r7.isSelected = true
            result_r7 = 4
        }
    }
    
    @IBAction func btQ9_r8(_ sender: UIButton) {
        if sender.tag == 1 {
            bt1_q9_r8.isSelected = true
            bt2_q9_r8.isSelected = false
            bt3_q9_r8.isSelected = false
            bt4_q9_r8.isSelected = false
            result_r8 = 1
        }else if sender.tag == 2 {
            bt1_q9_r8.isSelected = false
            bt2_q9_r8.isSelected = true
            bt3_q9_r8.isSelected = false
            bt4_q9_r8.isSelected = false
            result_r8 = 2
        }else if sender.tag == 3 {
            bt1_q9_r8.isSelected = false
            bt2_q9_r8.isSelected = false
            bt3_q9_r8.isSelected = true
            bt4_q9_r8.isSelected = false
            result_r8 = 3
        }else if sender.tag == 4 {
            bt1_q9_r8.isSelected = false
            bt2_q9_r8.isSelected = false
            bt3_q9_r8.isSelected = false
            bt4_q9_r8.isSelected = true
            result_r8 = 4
        }
    }
    
    @IBAction func btQ9_r9(_ sender: UIButton) {
        if sender.tag == 1 {
            bt1_q9_r9.isSelected = true
            bt2_q9_r9.isSelected = false
            bt3_q9_r9.isSelected = false
            bt4_q9_r9.isSelected = false
            result_r9 = 1
        }else if sender.tag == 2 {
            bt1_q9_r9.isSelected = false
            bt2_q9_r9.isSelected = true
            bt3_q9_r9.isSelected = false
            bt4_q9_r9.isSelected = false
            result_r9 = 2
        }else if sender.tag == 3 {
            bt1_q9_r9.isSelected = false
            bt2_q9_r9.isSelected = false
            bt3_q9_r9.isSelected = true
            bt4_q9_r9.isSelected = false
            result_r9 = 3
        }else if sender.tag == 4 {
            bt1_q9_r9.isSelected = false
            bt2_q9_r9.isSelected = false
            bt3_q9_r9.isSelected = false
            bt4_q9_r9.isSelected = true
            result_r9 = 4
        }
    }
    
    @IBAction func save(_ sender: UIButton) {
        result = result_r1 + result_r2 + result_r3 + result_r4 + result_r5 + result_r6 + result_r7 + result_r8 + result_r9
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
        
        
        let url = "https://moodapi.000webhostapp.com/DBMoody/assessment.php?"
        let param : Parameters = [
            "assess":assess as AnyObject,
            "result":result as AnyObject,
            "time":time as AnyObject,
            "date":dateString as AnyObject,
            "u_id":q9Id as AnyObject
        ]

        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
        switch response.result {
            case .success(_):
                print("success")
                if self.result >= 7 {
                    self.rated = "\"ระดับน้อย\""
                    if self.result >= 13 {
                        self.rated = "\"ระดับปานกลาง\""
                    }else if self.result >= 19{
                        self.rated = "\"ระดับรุนแรง\""
                    }
                    let alert = UIAlertController(title: "คุณมีแนวโน้มที่จะเป็นโรคซึมเศร้า \(self.rated) กรุณาทำแบบประเมินต่อ", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .cancel, handler:{(action) -> Void in
                        self.performSegue(withIdentifier: "to8q", sender: self)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else if self.result <= 6 {
                    let alert = UIAlertController(title: "คุณไม่มีแนวโน้มที่จะเป็นโรคซึมเศร้า", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .cancel, handler:{(action) -> Void in
                        self.performSegue(withIdentifier: "toAddmood", sender: self)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
            }
            case .failure(_):
                print("fail")
               
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to8q"{
            let Result_8q_viewController = segue.destination as! Result_8q_ViewController
            Result_8q_viewController.q8Id = self.q9Id
        }
        if segue.identifier == "toAddmood"{
            let addmoodViewController = segue.destination as! Addmood_ViewController
            addmoodViewController.amId = self.q9Id
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
