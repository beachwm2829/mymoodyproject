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
    var date :String?
    var result = 0
    var r1 = 0
    var r2 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(q2Id!)
        // Do any additional setup after loading the view.
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
        print(result)
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        print("\(hour):\(minutes):\(seconds)")
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = formatter.string(from: date)
        print(dateString)
        
        
        let url = "https://moodapi.000webhostapp.com/DBMoody/assessment.php?"
        let param : Parameters = [
            "assess":assess as AnyObject,
            "result":result as AnyObject,
            "hour":hour as AnyObject,
            "minutes":minutes as AnyObject,
            "seconds":seconds as AnyObject,
            "date":dateString as AnyObject,
            "u_id":q2Id as AnyObject
        ]

        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
        switch response.result {
            case .success(_):
                print("success")
            case .failure(_):
                print("fail")
               
            }
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
