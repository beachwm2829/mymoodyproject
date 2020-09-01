//
//  ViewController.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 4/8/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var lbInvalid: UILabel!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var loginBT: UIButton!
    @IBOutlet weak var createBT: UIButton!
    
    var vcId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBT.layer.cornerRadius = 20.0
        createBT.layer.cornerRadius = 20.0
        lbInvalid.isHidden = true
    }

    @IBAction func btLogin(_ sender: Any) {
        let url = "https://moodapi.000webhostapp.com/DBMoody/"
        let param : [String:AnyObject] = [
            "username":tfUsername.text! as AnyObject,
            "password":tfPassword.text! as AnyObject]
        
        AF.request(url+"login.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseJSON{ (response) in
            switch response.result {
            case .success(_):
                print(response)
                let data = JSON(response.data!)
                if(data["login"] == "true"){
                    self.vcId = data["u_id"].stringValue
                    if(data["status"] == "0"){
                        self.performSegue(withIdentifier: "toTabbar", sender: self)
                    }else{
                        self.performSegue(withIdentifier: "Resultcell", sender: self)
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
        if segue.identifier == "Resultcell"{
            let Result_q2_ViewController = segue.destination as! Result_q2_ViewController
            Result_q2_ViewController.q2Id = self.vcId
        }
        if segue.identifier == "toTabbar"{
            let TabbarController = segue.destination as! TabBarController
            TabbarController.tbId = self.vcId
        }

    }
    
}

