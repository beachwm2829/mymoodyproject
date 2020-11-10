//
//  CarerViewController.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 2/11/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class CarerViewController: UIViewController {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbSex: UILabel!
    @IBOutlet weak var lbBirth: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbDisease: UILabel!
    @IBOutlet weak var lbMail: UILabel!
    @IBOutlet weak var lbTel: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    var cvId :String?
    var uvId :String?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("cvId \(cvId)")
        let url = "http://project2.cocopatch.com/Moody/"
        let param : Parameters = ["u_id":self.cvId! as AnyObject]

        AF.request(url+"getProfile.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
            do {
                let jsondata = try JSON(data: response.data!)
                let ListUserArray = jsondata["success"].arrayValue
                for aListUser in ListUserArray {
                    let urlimg = URL(string: "http://project2.cocopatch.com/Moody/\(aListUser["img"])")
                    self.lbName.text = aListUser["name"].stringValue
                    self.lbSex.text = aListUser["gender"].stringValue
                    self.lbBirth.text = aListUser["birthdate"].stringValue
                    self.lbAddress.text = aListUser["address"].stringValue
                    self.lbDisease.text = aListUser["disease"].stringValue
                    self.lbMail.text = aListUser["email"].stringValue
                    self.lbTel.text = aListUser["phone"].stringValue
                    self.img.kf.setImage(with: urlimg)
                }
            }catch{
            }

        }

    }
    @IBAction func btDelCarer(_ sender: Any) {
    var refreshAlert = UIAlertController(title: "ยกเลิกการติดตามการดูแล", message: "คุณต้องการยกเลิกการติดตามดูแลหรือไม่", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "ตลลง", style: .default, handler: { (action: UIAlertAction!) in
            let url = "http://project2.cocopatch.com/Moody/"
            let param : Parameters = [
                "mode":"deleteCarer" as AnyObject,
                "u_id":self.uvId as AnyObject
            ]

            AF.request(url+"searchUser.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
                switch response.result {
                case .success(_):
                    let alert = UIAlertController(title: "ลบผู้ดูแลเรียบร้อย", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .cancel, handler:{(action) -> Void in
                        self.navigationController!.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                case .failure(_):
                    let alert = UIAlertController(title: "ข้อผิดพลาดเซิร์ฟเวอร์", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ลองอีกครั้ง", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }))

        refreshAlert.addAction(UIAlertAction(title: "ยกเลิก", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Cancel Logic here")
        }))

        present(refreshAlert, animated: true, completion: nil)

    }
    
    
}
