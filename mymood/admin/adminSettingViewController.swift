//
//  adminSettingViewController.swift
//  mymood
//
//  Created by macOS on 10/20/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
//import AlamofireImage
import SwiftyJSON
import ObjectMapper

class adminSettingViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var adSId:String?
    
    
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfFname: UITextField!
    @IBOutlet weak var tfLname: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfBirth: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    
    
    
    @IBOutlet weak var btMale: UIButton!
    @IBOutlet weak var btFemale: UIButton!
 
    @IBOutlet weak var img: UIImageView!
    
    let datePicker = UIDatePicker()
    var word = ""
    var photoBase64:String?
    var nameArr:String?
    var gender = ""
    var status : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        

        img.layer.cornerRadius = img.frame.size.height/2
        
        print(adSId)
        let url = "http://project2.cocopatch.com/Moody/"
        let param : Parameters = ["u_id":self.adSId as AnyObject]

        AF.request(url+"getProfile.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
            do {
                //print("do")
                let jsondata = try JSON(data: response.data!)
                print("this here popuser")
                let ListUserArray = jsondata["success"].arrayValue
                for aListUser in ListUserArray {
                    let popListUserId = aListUser["u_id"].stringValue
                    
                    self.tfPassword.text = aListUser["password"].stringValue
                    
                    let name = aListUser["name"].stringValue
                    let nameArr = name.components(separatedBy: " ")
                    
                    if (nameArr.count == 0) {
                        self.tfFname.text = ""
                        self.tfLname.text = ""
                    }else if (nameArr.count == 1) {
                        self.tfFname.text = nameArr[0]
                        self.tfLname.text = ""
                    }else if (nameArr.count == 2) {
                        self.tfFname.text = nameArr[0]
                        self.tfLname.text = nameArr[1]
                    }
                    self.tfEmail.text = aListUser["email"].stringValue
                    self.tfPhone.text = aListUser["phone"].stringValue
                    self.tfBirth.text = aListUser["birthdate"].stringValue
                    self.tfAddress.text = aListUser["address"].stringValue
                    let imgprofile = aListUser["img"].stringValue
                    let url = URL(string: "http://project2.cocopatch.com/Moody/\(imgprofile)")
                    self.img.kf.setImage(with: url)
//                    print("ListUsers\(self.ListUsers)")
                }
            }catch{
            }
        }

    }
    
    @objc func viewTapped(gestureRecongizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey:Any]) {
        let images = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        img.contentMode = .scaleToFill
        img.image = images
        
        let imageData:NSData = images.jpegData(compressionQuality: 0.4)! as NSData
        photoBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        word = "data:image/jpg;base64,\(photoBase64!)"
        dismiss(animated: true, completion:nil)
        
    }
    
    func imagePickerControllerDidCancel(_ Picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btProfile(_ sender: UIButton) {
        print("button")
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let litButton = UIAlertAction(title: "คลังรูปภาพ", style: UIAlertAction.Style.default){(litSelect) in
            print("Library")
            let selectPhoto = UIImagePickerController()
            selectPhoto.delegate = self
            selectPhoto.sourceType = .photoLibrary
            self.present(selectPhoto, animated: true, completion: nil)
            
        }
        let camButton = UIAlertAction(title: "ถ่ายภาพ", style: UIAlertAction.Style.default){(litSelect) in
            print("Camera")
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
            
        }
        let cancleButton = UIAlertAction(title: "ยกเลิก", style: UIAlertAction.Style.cancel){(canSelect) in
            print("Cancle")
            
        }
        actionSheet.addAction(camButton)
        actionSheet.addAction(litButton)
        actionSheet.addAction(cancleButton)
        self.present(actionSheet,animated: true,completion: nil)
    }
    
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBth = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBth], animated: true)
        tfBirth.inputAccessoryView = toolbar
        tfBirth.inputView = datePicker
        
        datePicker.datePickerMode = .date
        
    }
    @objc func donePressed() {
        let fotmatter = DateFormatter()
        fotmatter.dateFormat = "yyyy-MM-dd"
    
        tfBirth.text = fotmatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @IBAction func btRadioGender(_ sender: UIButton) {
        if sender.tag == 1 {
            btMale.isSelected = true
            btFemale.isSelected = false
            gender = "male"
        }else if sender.tag == 2 {
            btFemale.isSelected = true
            btMale.isSelected = false
            gender = "female"
        }
    }

    @IBAction func btCreateAccount(_ sender: Any) {
        let url = "https://moodapi.000webhostapp.com/DBMoody/register.php?"
        let param : Parameters = [
            "password":tfPassword.text! as AnyObject,
            "fname":tfFname.text! as AnyObject,
            "lname":tfLname.text! as AnyObject,
            "gender":gender as AnyObject,
            "birthdate":tfBirth.text! as AnyObject,
            "phone":tfPhone.text! as AnyObject,
            "address":tfAddress.text! as AnyObject,
            "email":tfEmail.text! as AnyObject,
            "img":word as AnyObject,
            "status":status as AnyObject
        ]
        
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
        switch response.result {
            case .success(_):
                let alert = UIAlertController(title: "แก้ไขข้อมูลเรียบร้อย", message: nil, preferredStyle: .alert)
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
    }

}
