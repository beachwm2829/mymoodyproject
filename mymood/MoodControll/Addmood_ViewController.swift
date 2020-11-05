//
//  Addmood_ViewController.swift
//  mymood
//
//  Created by macOS on 8/17/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
//import AlamofireImage
import SwiftyJSON
import GooglePlaces
import Charts


class Addmood_ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var imgmood = UIImage()
    var mood = 0
    var amId :String?
    
    @IBOutlet weak var lb_addres: UILabel!
    @IBOutlet weak var ldname_location: UILabel!
    var placesClient: GMSPlacesClient!
    
    var moodData = [[String:AnyObject]]()
    
    let datePicker = UIDatePicker()
    var word = ""
    var photoBase64:String?
    var mode = ""
    
    var activitySH:String?
    @IBOutlet weak var imgactivity: UIImageView!
    
    @IBOutlet weak var bt_mood1: UIButton!
    @IBOutlet weak var bt_mood2: UIButton!
    @IBOutlet weak var bt_mood3: UIButton!
    @IBOutlet weak var bt_mood4: UIButton!
    @IBOutlet weak var bt_mood5: UIButton!
       
    @IBOutlet weak var lb_note: UITextField!
    @IBOutlet weak var lbHastag: UITextField!
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("amId\(amId)")
        
        self.ldname_location.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(handle), name: NSNotification.Name(rawValue: "saveActivity"), object: nil)
    }
    
    @objc func handle(notification : Notification){
        let mooodVc = notification.object as! add_activityViewController
        activitySH = mooodVc.activity
        imgactivity.image = UIImage(named: activitySH!)
        
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func btMoodControl(_ sender: UIButton) {
        if sender.tag == 1 {
            bt_mood1.isSelected = true
            bt_mood2.isSelected = false
            bt_mood3.isSelected = false
            bt_mood4.isSelected = false
            bt_mood5.isSelected = false
            mood = 1
        }else if sender.tag == 2 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = true
            bt_mood3.isSelected = false
            bt_mood4.isSelected = false
            bt_mood5.isSelected = false
            mood = 2
        }else if sender.tag == 3 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = false
            bt_mood3.isSelected = true
            bt_mood4.isSelected = false
            bt_mood5.isSelected = false
            mood = 3
        }else if sender.tag == 4 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = false
            bt_mood3.isSelected = false
            bt_mood4.isSelected = true
            bt_mood5.isSelected = false
            mood = 4
        }else if sender.tag == 5 {
            bt_mood1.isSelected = false
            bt_mood2.isSelected = false
            bt_mood3.isSelected = false
            bt_mood4.isSelected = false
            bt_mood5.isSelected = true
            mood = 5
        }
    }

    @IBAction func btAddImages(_ sender: Any) {
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
    //MARK: - host addmood
   @IBAction func btsavemood(_ sender: Any) {
    let url = "http://project2.cocopatch.com/Moody/mood.php?"
    
    let date = Date()
    let calendar = Calendar.current
    
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    let seconds = calendar.component(.second, from: date)

    let time = "\(hour):\(minutes):\(seconds)"

    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en")
    formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
    formatter.dateFormat = "yyyy-MM-dd"
    
    let dateString = formatter.string(from: date)
    mode = "insert"
    
    if lb_note.text == "" || lbHastag.text == "" || imgactivity.image == nil || img.image == nil {

        let alertController = UIAlertController(title: "Alert", message: "กรุณากรอกข้อมูลให้ครบ", preferredStyle: UIAlertController.Style.alert)
        let DestructiveAction = UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            print("Settings")
        }

        alertController.addAction(DestructiveAction)

        self.present(alertController, animated: true, completion: nil)
    }

    let param : Parameters = [
        "mood":mood as AnyObject,
        "activity":activitySH as AnyObject,
        "note":lb_note.text! as AnyObject,
        "location":ldname_location.text! as AnyObject,
        "hastag":lbHastag.text! as AnyObject,
        "time":time as AnyObject,
        "date":dateString as AnyObject,
        "img":word as AnyObject,
        "u_id":amId! as AnyObject,
        "mode":mode as AnyObject
        ]
    AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
    switch response.result {
        case .success(_):
            let alert = UIAlertController(title: "เพิ่มข้อมูลอารมณ์เรียบร้อย", message: nil, preferredStyle: .alert)
            self.getAlertmood()
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
    //MARK: - GET AlertMood
    func getAlertmood(){
        let url = "http://project2.cocopatch.com/Moody/resultmood.php?"
        let param : Parameters = [
            "u_id":amId! as AnyObject,
            "c_id":"59" as AnyObject,
            "mode":"get" as AnyObject
        ]

        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
            switch response.result {
                case .success(_):
                    print("success")
                case .failure(_):
                    print("failure")
            }
        }
    }
    
    @IBAction func btLocation(_ sender: Any) {
       let autocompleteController = GMSAutocompleteViewController()
       autocompleteController.delegate = self
       present(autocompleteController, animated: true, completion: nil)
        
    }
   
    func resetComp(){
        bt_mood1.isSelected = false
        bt_mood2.isSelected = false
        bt_mood3.isSelected = false
        bt_mood4.isSelected = false
        bt_mood5.isSelected = false
        
        lbHastag.text = ""
        lb_note.text = ""
        ldname_location.text = ""
        img.image = nil
        imgactivity.image = nil
    }
    
    @IBAction func btBack(_ sender: Any) {
        navigationController?.pushViewController(MoodViewController(), animated: true)
    }
    
    
}
extension Addmood_ViewController: GMSAutocompleteViewControllerDelegate {
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    ldname_location.text = String(place.name!)
    self.ldname_location.isHidden = false
    print("Place name: \(place.name)")
    print("Place ID: \(place.placeID)")
    print("Place attributions: \(place.attributions)")
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

}

