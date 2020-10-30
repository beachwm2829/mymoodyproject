//
//  AlarmViewController.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 28/10/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlarmViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var viewAl: UIView!
    @IBOutlet weak var tfNote: UITextField!
    
    var alId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAl.layer.borderWidth = 2
        viewAl.layer.borderColor = UIColor.black.cgColor
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func SaveAlram(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        let dateString = formatter.string(from: datePicker.date)
        print("dateString :: \(dateString)")
        
        let url = "http://project2.cocopatch.com/Moody/fcm.php?"
        let param : Parameters = [
            "body":tfNote.text as AnyObject,
            "time":dateString as AnyObject,
            "uid":alId as AnyObject
        ]

        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil)
        self.dismiss(animated: true)
    }
    
}
