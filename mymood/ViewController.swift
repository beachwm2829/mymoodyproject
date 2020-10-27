//
//  ViewController.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 4/8/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
//import AlamofireImage
import SwiftyJSON
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var lbInvalid: UILabel!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var loginBT: UIButton!
    @IBOutlet weak var createBT: UIButton!
    
    var vcId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let content = UNMutableNotificationContent()
        content.title = "MYMOODY"
        content.body = "Welcome"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: trigger)
        
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        loginBT.layer.cornerRadius = 20.0
        createBT.layer.cornerRadius = 20.0
        tfUsername.text = ""
        tfPassword.text = ""
        lbInvalid.isHidden = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func btLogin(_ sender: Any) {
        let url = "http://project2.cocopatch.com/Moody/"
        let param : [String:AnyObject] = [
            "username":tfUsername.text! as AnyObject,
            "password":tfPassword.text! as AnyObject]
        
        AF.request(url+"login.php?", method: .post, parameters: param,
                   encoding: JSONEncoding.default,
                   headers: nil).validate().responseJSON{ (response) in
            switch response.result {
            case .success(_):
                print(response)
                let data = JSON(response.data!)
                if(data["login"] == "true"){
                    self.vcId = data["u_id"].stringValue
                    if(data["status"] == "2"){
                        self.performSegue(withIdentifier: "toTabbaradmin", sender: self)
                    }else if(data["status_As"] == "0"){
                        self.performSegue(withIdentifier: "toTabbar", sender: self)
                    }else{
                        self.performSegue(withIdentifier: "toAses", sender: self)
                    }
                    
                }else{
                    self.lbInvalid.isHidden = false
                }
            case .failure(_):
                print(response)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAses"{
            let Result_q2 = segue.destination as! Result_q2_ViewController
                Result_q2.q2Id = self.vcId
        }
        if segue.identifier == "toTabbar"{
            let TabbarController = segue.destination as! TabBarController
            TabbarController.tbId = self.vcId
        }
        if segue.identifier == "toTabbaradmin"{
            if let ListUserVC = segue.destination as? UINavigationController, let ListUserViewController = ListUserVC.topViewController as? ListUserViewController{
                ListUserViewController.amintbId = self.vcId
            }
            
        }
    }
    
}
