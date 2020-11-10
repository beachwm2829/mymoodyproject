//
//  RegisterViewController.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 12/8/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
//import AlamofireImage
import SwiftyJSON
import ObjectMapper

class RegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfFname: UITextField!
    @IBOutlet weak var tfLname: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfBirth: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfDisease: UITextField!
    
    @IBOutlet weak var btCreate: UIButton!
    @IBOutlet weak var btMale: UIButton!
    @IBOutlet weak var btFemale: UIButton!
    @IBOutlet weak var btUser: UIButton!
    @IBOutlet weak var btCarer: UIButton!
    
    @IBOutlet weak var img: UIImageView!
    
    let datePicker = UIDatePicker()
    var word = ""
    var photoBase64:String?
    var rcId : String?
    var gender = ""
    var status : Int?
    
    var emailValid:String?
    var userValid:String?
    var passValid:String?
    var phoneValid:String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btCreate.layer.cornerRadius = 20.0
        createDatePicker()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecongizer: )))
        view.addGestureRecognizer(tap)
        
        img.layer.cornerRadius = img.frame.size.height/2
//        tfUsername.addTarget(self,
//                action : #selector(textFieldDidChange),
//                for : .editingChanged)
    }
    @IBAction func user_act(_ sender: Any){
        let text = tfUsername.text!
        if text.isValidUser() {
            tfUsername.textColor = UIColor.black
            userValid = "true"
        }else {
            tfUsername.textColor = UIColor.red
            userValid = "false"
        }
    }
    @IBAction func pass_act(_ sender: Any){
        let text = tfPassword.text!
        if text.isValidPass() {
            tfPassword.textColor = UIColor.black
            passValid = "true"
        }else {
            tfPassword.textColor = UIColor.red
            passValid = "false"
        }
    }
    @IBAction func email_act(_ sender: Any){
        let text = tfEmail.text!
        if text.isValidEmail() {
            tfEmail.textColor = UIColor.black
            emailValid = "true"
        }else {
            tfEmail.textColor = UIColor.red
            emailValid = "false"
        }
    }
    @IBAction func phone_act(_ sender: Any){
        let text = tfPhone.text!
        if text.isValidPhone() {
            tfPhone.textColor = UIColor.black
            phoneValid = "true"
        }else {
            tfPhone.textColor = UIColor.red
            phoneValid = "false"
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
        datePicker.preferredDatePickerStyle = .wheels
        
    }
    @objc func donePressed() {
        let fotmatter = DateFormatter()
        fotmatter.locale = Locale(identifier: "en")
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
    
    @IBAction func btRadioStatus(_ sender: UIButton) {
        if sender.tag == 1 {
            btUser.isSelected = true
            btCarer.isSelected = false
            status = 1
        }else if sender.tag == 2 {
            btCarer.isSelected = true
            btUser.isSelected = false
            status = 2
        }
    }
    @IBAction func btback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btCreateAccount(_ sender: Any) {
        let Email:String = tfEmail.text!
        let username:String = tfUsername.text!
        let password:String = tfPassword.text!
        let phone:String = tfPhone.text!
        let birth:String = tfBirth.text!
        let fname:String = tfFname.text!
        let lname:String = tfLname.text!
        
        if Email.isEmpty || username.isEmpty || password.isEmpty || phone.isEmpty || birth.isEmpty
            || fname.isEmpty || lname.isEmpty || self.gender.isEmpty || self.status == 0 {
            let alertController = UIAlertController(title: "Alert", message: "กรุณากรอกข้อมูลให้ครบ", preferredStyle: UIAlertController.Style.alert)
            let DestructiveAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                print("Settings")
            }
            alertController.addAction(DestructiveAction)
            self.present(alertController, animated: true, completion: nil)
        }else if  userValid == "false"{
            let alertController = UIAlertController(title: "Username ไม่ถูกต้อง", message: "กรุณากรอก username ให้ครบ 6 ตัว มีตัวอักษรกับตัวเลข", preferredStyle: UIAlertController.Style.alert)
            let DestructiveAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                print("Settings")
            }
            alertController.addAction(DestructiveAction)
            self.present(alertController, animated: true, completion: nil)
        }else if  passValid == "false"{
            let alertController = UIAlertController(title: "Password ไม่ถูกต้อง", message: "กรุณากรอก password อย่างน้อย 6 ตัว มีตัวอักษรกับตัวเลข", preferredStyle: UIAlertController.Style.alert)
            let DestructiveAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                print("Settings")
            }
            alertController.addAction(DestructiveAction)
            self.present(alertController, animated: true, completion: nil)
        }else if  emailValid == "false"{
            let alertController = UIAlertController(title: "Email ไม่ถูกต้อง", message: "กรุณากรอก Email ให้ถูกต้อง", preferredStyle: UIAlertController.Style.alert)
            let DestructiveAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                print("Settings")
            }
            alertController.addAction(DestructiveAction)
            self.present(alertController, animated: true, completion: nil)
        }else if  phoneValid == "false"{
            let alertController = UIAlertController(title: "เบอร์โทรศัพท์ ไม่ถูกต้อง", message: "กรุณากรอกเบอร์โทรศัพท์ ให้ถูกต้อง", preferredStyle: UIAlertController.Style.alert)
            let DestructiveAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                print("Settings")
            }
            alertController.addAction(DestructiveAction)
            self.present(alertController, animated: true, completion: nil)
        }else {
            let url = "http://project2.cocopatch.com/Moody/register.php?"
            let param : Parameters = ["username":tfUsername.text! as AnyObject,
                "password":tfPassword.text! as AnyObject,
                "mode":"register" as AnyObject,
                "fname":tfFname.text! as AnyObject,
                "lname":tfLname.text! as AnyObject,
                "gender":gender as AnyObject,
                "birthdate":tfBirth.text! as AnyObject,
                "phone":tfPhone.text! as AnyObject,
                "address":tfAddress.text! as AnyObject,
                "disease":tfDisease.text! as AnyObject,
                "email":tfEmail.text! as AnyObject,
                "img":word as AnyObject,
                "status":status as AnyObject
            ]
            AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
            switch response.result {
                case .success(_):
                    let alert = UIAlertController(title: "สมัครสมาชิกเรียบร้อย", message: nil, preferredStyle: .alert)
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
//                else if ( !password.isEqual(confirm_password) ) {
//
//                    let alertController = UIAlertController(title: "Alert", message: "Password Din't Match.", preferredStyle: UIAlertControllerStyle.Alert)
//                    let DestructiveAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
//                        print("Password Din't Match")
//                    }
//
//                    alertController.addAction(DestructiveAction)
//
//                    self.presentViewController(alertController, animated: true, completion: nil)
//
//                }
                    
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    func isValidUser() -> Bool {
        let userRegEx = "^(?=.*[a-z]).{6,}$"
        let userTest = NSPredicate(format:"SELF MATCHES %@", userRegEx)
        return userTest.evaluate(with: self)
    }

    func isValidPass() -> Bool {
        let passRegEx = "^(?=.*[a-z])(?=.*[0-9]).{6,}$"
        let passTest = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passTest.evaluate(with: self)
    }

    func isValidPhone() -> Bool {
        let phoneRegEx = "^(0)[0-9]{9,9}$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }
}

