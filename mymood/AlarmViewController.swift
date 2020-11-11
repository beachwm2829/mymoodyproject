//  AlarmViewController.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 28/10/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import UserNotifications

class AlarmViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var viewAl: UIView!
    @IBOutlet weak var tfNote: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    
    var alId: String?
    var pickerData: [String] = [String]()
    var pickercount:String?
    var day:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
                
        // Input the data into the array
        pickerData = ["Sunday" ,"Monday" ,"Tuesday" ,"Wednesday" ,"Thursday" ,"Friday" ,"Saturday"]
        
        viewAl.layer.borderWidth = 2
        viewAl.layer.borderColor = UIColor.black.cgColor
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func SaveAlram(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"

        let dateString = formatter.string(from: datePicker.date)
        print("dateString :: \(dateString)")
        
        let date = datePicker.date
        var calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        if pickercount == "Sunday"{
            day = 1
        }else if pickercount == "Monday" {
            day = 2
        }else if pickercount == "Tuesday" {
            day = 3
        }else if pickercount == "Wednesday" {
            day = 4
        }else if pickercount == "Thursday" {
            day = 5
        }else if pickercount == "Friday" {
            day = 6
        }else if pickercount == "Saturday" {
            day = 7
        }
        print("Weekday : \(day!)")
        print("body : \(tfNote.text!)")
        print("Hour : \(hour)")
        print("Minute : \(minute)")

        let content = UNMutableNotificationContent()
        content.title = "MYMOODY"
        content.body = tfNote.text!
        content.sound = UNNotificationSound.default

        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.weekday = day!  // Sunday Monday Tuesday wednesday thursday friday saturday
        dateComponents.hour = hour
        dateComponents.minute = minute

        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)

        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

//        let url = "http://project2.cocopatch.com/Moody/fcm.php?"
//        let param : Parameters = [
//            "body":tfNote.text as AnyObject,
//            "time":dateString as AnyObject,
//            "uid":alId as AnyObject
//        ]
//
//        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil)
        self.dismiss(animated: true)
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


}
