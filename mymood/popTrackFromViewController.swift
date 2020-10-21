//
//  popTrackFromViewController.swift
//  mymood
//
//  Created by macOS on 10/20/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
//import AlamofireImage
import SwiftyJSON
import GooglePlaces
import Charts

class popTrackFromViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var tkId:String?
    
    @IBOutlet weak var lbcomment: UITextField!
    @IBOutlet weak var lbtime: UILabel!
    @IBOutlet weak var lbdate: UILabel!
    @IBOutlet weak var lbDr_name: UILabel!
    @IBOutlet weak var lbDr_email: UILabel!
    @IBOutlet weak var lbphone: UILabel!
    @IBOutlet weak var lbhospital: UILabel!
    @IBOutlet weak var lbdrug: UILabel!
    @IBOutlet weak var lbtime_next: UILabel!
    @IBOutlet weak var lbdate_next: UILabel!
    
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
                print("ListUserArray\(TrackFromArray)")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
        print("Save => track")
    }
    
}
