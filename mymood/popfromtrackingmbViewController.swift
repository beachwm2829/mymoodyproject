//
//  popfromtrackingmbViewController.swift
//  mymood
//
//  Created by macOS on 10/21/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
//import AlamofireImage
import SwiftyJSON
import GooglePlaces
import Charts

class popfromtrackingmbViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var tkId:String?
    
    @IBOutlet weak var lbcomment: UILabel!
    @IBOutlet weak var lbtime: UITextField!
    @IBOutlet weak var lbdate: UITextField!
    @IBOutlet weak var lbDr_name: UITextField!
    @IBOutlet weak var lbDr_email: UITextField!
    @IBOutlet weak var lbphone: UITextField!
    @IBOutlet weak var lbhospital: UITextField!
    @IBOutlet weak var lbdrug: UITextField!
    @IBOutlet weak var lbtime_next: UITextField!
    @IBOutlet weak var lbdate_next: UITextField!
    @IBOutlet weak var imgview: UIImageView!
    
    let datePicker = UIDatePicker()
    var word = ""
    var photoBase64:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tkId)
        let url = "http://project2.cocopatch.com/Moody/"
        let param : Parameters = ["tf_id":self.tkId as AnyObject]

        AF.request(url+"getDetailFromTracking.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
            do {
                print("do")
                let jsondata = try JSON(data: response.data!)
                print("this here popuser \(jsondata)")
                let TrackFromArray = jsondata["success"].arrayValue
                print("TrackFromArray\(TrackFromArray)")
                for aTrackFrom in TrackFromArray {
                    let popListUserId = aTrackFrom["u_id"].stringValue
                    self.lbcomment.text = aTrackFrom["comment"].stringValue
                    self.lbtime.text = aTrackFrom["time"].stringValue
//                    self.lbbirth.text = aListUser["birthdate"].stringValue
//                    self.lbdisease.text = aListUser["disease"].stringValue
//                    self.lbadrees.text = aListUser["adress"].stringValue
//                    self.lbmail.text = aListUser["email"].stringValue
//                    self.lbtel.text = aListUser["phone"].stringValue
//                    let imgprofile = aListUser["img"].stringValue
//                    let url = URL(string: "http://project2.cocopatch.com/Moody/\(imgprofile)")
//                    self.imgProfile.kf.setImage(with: url)
//                    print("ListUsers\(self.ListUsers)")
                }
            }catch{print("goal => ")
            }
        }
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey:Any]) {
        let images = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imgview.contentMode = .scaleToFill
        imgview.image = images
        
        let imageData:NSData = images.jpegData(compressionQuality: 0.4)! as NSData
        photoBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        word = "data:image/jpg;base64,\(photoBase64!)"
        dismiss(animated: true, completion:nil)
        
    }
    
    func imagePickerControllerDidCancel(_ Picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func bt_abum(_ sender: Any) {
         let selectPhoto = UIImagePickerController()
         selectPhoto.delegate = self
         selectPhoto.sourceType = .photoLibrary
         present(selectPhoto, animated: true,completion: nil)
     }
     @IBAction func bt_camera(_ sender: Any) {
         let selectPhoto = UIImagePickerController()
         selectPhoto.delegate = self
         selectPhoto.sourceType = .camera
         present(selectPhoto, animated: true,completion: nil)
     }
    @IBAction func btsave(_ sender: Any) {
        let url = "http://project2.cocopatch.com/Moody/FromTrack.php?"
        let param : Parameters = ["tf_id":self.tkId as AnyObject,"comment":self.lbcomment.text as AnyObject,"mode":"update" as AnyObject]

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
