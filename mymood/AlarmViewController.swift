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

        let content = UNMutableNotificationContent()
        content.title = "MYMOODY"
        content.body = "Welcome"
        content.sound = UNNotificationSound.default

        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.weekday = 2  // Sunday Monday Tuesday wednesday thursday friday saturday
        dateComponents.hour = 18
        dateComponents.minute = 40

        print(dateComponents.hour)

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

}
