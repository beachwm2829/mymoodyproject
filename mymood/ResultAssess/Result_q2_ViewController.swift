//
//  Result_q2_ViewController.swift
//  myAlamofire
//
//  Created by Manasawee Kaenampornpan on 30/4/2563 BE.
//  Copyright © 2563 iClassroom510-30. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Result_q2_ViewController: UIViewController {

    
    @IBOutlet weak var btTure_q2_r1: UIButton!
    @IBOutlet weak var btFalse_q2_r1: UIButton!
    
    @IBOutlet weak var btTure_q2_r2: UIButton!
    @IBOutlet weak var btFalse_q2_r2: UIButton!
    
    var q2Id :String?
    var assess = "Q2"
    var result = 0
    var r1 = 0
    var r2 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func btQ2_r1(_ sender: UIButton) {
        if sender.tag == 1 {
            btTure_q2_r1.isSelected = true
            btFalse_q2_r1.isSelected = false
            r1 = 1
        }else if sender.tag == 2 {
            btTure_q2_r1.isSelected = false
            btFalse_q2_r1.isSelected = true
            r1 = 0
        }
    }
    @IBAction func btQ2_r2(_ sender: UIButton) {
        if sender.tag == 1 {
            btTure_q2_r2.isSelected = true
            btFalse_q2_r2.isSelected = false
            r2 = 1
        }else if sender.tag == 2 {
            btFalse_q2_r2.isSelected = true
            btTure_q2_r2.isSelected = false
            r2 = 0
            
        }
    }
    
    @IBAction func b(_ sender: UIButton) {
        result = r1 + r2
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
            "u_id":q2Id as AnyObject
        ]

        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
        switch response.result {
            case .success(_):
                print("success")
                if self.result >= 1 {
                    let alert = UIAlertController(title: "คุณมีแนวโน้มที่จะเป็นโรคซึมเศร้า กรุณาทำแบบประเมินต่อ", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .cancel, handler:{(action) -> Void in
                        self.performSegue(withIdentifier: "to9q", sender: self)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else if self.result == 0 {
                    let alert = UIAlertController(title: "คุณไม่มีแนวโน้มที่จะเป็นโรคซึมเศร้า", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .cancel, handler:{(action) -> Void in
                        self.performSegue(withIdentifier: "toaddMood", sender: self)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
            }
            case .failure(_):
                print("fail")
               
            }
        }
    }
    
    @IBAction func btback(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to9q"{
            let Result_q9_viewController = segue.destination as! Result_q9_ViewController
            Result_q9_viewController.q9Id = self.q2Id
        }
        if segue.identifier == "toaddMood"{
            let addmoodViewController = segue.destination as! Addmood_ViewController
            addmoodViewController.amId = self.q2Id
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
