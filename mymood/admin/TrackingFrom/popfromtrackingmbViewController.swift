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
     var lbtime: String?
     var lbdate: String?
    
    @IBOutlet weak var lbDr_name: UITextField!
    @IBOutlet weak var lbDr_email: UITextField!
    @IBOutlet weak var lbphone: UITextField!
    @IBOutlet weak var lbhospital: UITextField!
    @IBOutlet weak var lbdrug: UITextField!
    var lbtime_next: String?
    var lbdate_next: String?
    @IBOutlet weak var imgview: UIImageView!
    
    var lbtimes: String?
    var lbdates: String?
   var lbtime_nexts: String?
   var lbdate_nexts: String?
    
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var dateTimenextPicker: UIDatePicker!
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
                    self.lbtime = aTrackFrom["time"].stringValue
                    self.lbdate = aTrackFrom["date"].stringValue
                    self.lbDr_name.text = aTrackFrom["dr_name"].stringValue
                    self.lbDr_email.text = aTrackFrom["email"].stringValue
                    self.lbphone.text = aTrackFrom["phone"].stringValue
                    self.lbhospital.text = aTrackFrom["hospital"].stringValue
                    self.lbdrug.text = aTrackFrom["drug"].stringValue
                    self.lbtime_next = aTrackFrom["time_next"].stringValue
                    self.lbdate_next = aTrackFrom["date_next"].stringValue
                    let imgprofile = aTrackFrom["image"].stringValue
                    print("imgprofile!\(imgprofile)")
                    let url = URL(string: "http://project2.cocopatch.com/Moody/\(imgprofile)")
                    self.imgview.kf.setImage(with: url)
                    
                    let strDate : String! = "\(self.lbdate!+" "+self.lbtime!)"
                    let strDateNext : String! = "\(self.lbdate_next!+" "+self.lbtime_next!)"
                    if (strDate == "0000-00-00 00:00:00"){
                        print("date Time Error!!")
                    }else{
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        dateFormatter.locale = Locale(identifier: "en")
                        let date = dateFormatter.date(from: strDate)
                //        self.dateTimePicker.datePickerMode = .date
                        self.dateTimePicker.setDate(date!, animated: false)
                    }
                    if(strDateNext == "0000-00-00 00:00:00"){
                        print("date Time DUE Error!!")
                    }else{
                        let dateFormatterNext = DateFormatter()
                        dateFormatterNext.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        dateFormatterNext.locale = Locale(identifier: "en")
                        let dateNext = dateFormatterNext.date(from: strDateNext)
                //        self.dateTimePicker.datePickerMode = .date
                        self.dateTimenextPicker.setDate(dateNext!, animated: false)
                    }
                    
                }
            }catch{print("goal => ")
            }
        }
        
        print(" self.lbtime\(self.lbtime)self.lbdate\(self.lbdate)self.lbtime_next\(self.lbtime_next)self.lbdate_next\(self.lbdate_next)")
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
        dateTimePicker.preferredDatePickerStyle = .compact
        dateTimenextPicker.preferredDatePickerStyle = .compact
            let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let selectedDate = dateFormatter.string(from: dateTimePicker.date)
        var timeArr = selectedDate.components(separatedBy: " ")
        self.lbtime = timeArr[0]
        self.lbdate = timeArr[1]
                    print("selectedDate",selectedDate)
        dateTimenextPicker.preferredDatePickerStyle = .compact
            let dateFormatternext = DateFormatter()
                    dateFormatternext.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let selectedDatenext = dateFormatternext.string(from: dateTimenextPicker.date)
        var timeArrnext = selectedDatenext.components(separatedBy: " ")
        self.lbtime_next = timeArrnext[0]
        self.lbdate_next = timeArrnext[1]
                    print("selectedDatenext",selectedDatenext)
        print(" self.lbtime\(self.lbtime)self.lbdate\(self.lbdate)self.lbtime_next\(self.lbtime_next)self.lbdate_next\(self.lbdate_next)")
        let url = "http://project2.cocopatch.com/Moody/FromTrack.php?"
        let param : Parameters = ["u_id":self.tkId as AnyObject,
                                  "time":self.lbtime as AnyObject,
                                  "date":self.lbdate as AnyObject,
                                  "dr_name":self.lbDr_name.text as AnyObject,
                                  "email":self.lbDr_email.text as AnyObject,
                                  "phone":self.lbphone.text as AnyObject,
                                  "hospital":self.lbhospital.text as AnyObject,
                                  "drug":self.lbdrug.text as AnyObject,
                                  "time_next":self.lbtime_next as AnyObject,
                                  "date_next":self.lbdate_next as AnyObject,
                                  "image":self.word as AnyObject,
                                  "mode":"userupdate" as AnyObject]
print(param)
      
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
        switch response.result {
            case .success(_):
                let alert = UIAlertController(title: "เพิ่มฟอร์มการติดตามเรียบร้อย", message: nil, preferredStyle: .alert)
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
