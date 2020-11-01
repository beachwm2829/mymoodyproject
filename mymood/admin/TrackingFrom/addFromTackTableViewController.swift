//
//  addFromTackTableViewController.swift
//  mymood
//
//  Created by macOS on 11/2/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//addFromTackTableViewController

import UIKit
import Alamofire
//import AlamofireImage
import SwiftyJSON
import GooglePlaces
import Charts

class addFromTackTableViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var tkId:String?
    @IBOutlet weak var lbcomment: UITextField!

    
    let datePicker = UIDatePicker()
    var word = ""
    var photoBase64:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("tkId\(tkId)")
       
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func btsave(_ sender: Any) {
        let url = "http://project2.cocopatch.com/Moody/FromTrack.php?"
        let param : Parameters = ["u_id":self.tkId as  AnyObject,
                                  "comment":self.lbcomment.text as AnyObject]
print(param)
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
        switch response.result {
            case .success(_):
                let alert = UIAlertController(title: "เพิ่มหมายเหตุเรียบร้อย", message: nil, preferredStyle: .alert)
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
        print("Save => track")
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
