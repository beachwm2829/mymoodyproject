//
//  Addmood_ViewController.swift
//  mymood
//
//  Created by macOS on 8/17/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import GooglePlaces


class Addmood_ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var Id : String?
    var imgmood = UIImage()
    var mood = UITextField()
    
    @IBOutlet weak var lb_addres: UILabel!
    @IBOutlet weak var ldname_location: UILabel!
    var placesClient: GMSPlacesClient!
    
    var tdId:String?
    var moodData = [[String:AnyObject]]()
    
    let datePicker = UIDatePicker()
    var word = "data:image/jpg;base64,"
    var photoBase64:String?
       
       @IBOutlet weak var bt_mood1: UIButton!
       @IBOutlet weak var bt_mood2: UIButton!
       @IBOutlet weak var bt_mood3: UIButton!
       @IBOutlet weak var bt_mood4: UIButton!
       @IBOutlet weak var bt_mood5: UIButton!
       
       @IBOutlet weak var lb_note: UITextField!
       @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey:Any]) {
        let images = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        img.contentMode = .scaleToFill
        img.image = images
        
        let imageData:NSData = images.jpegData(compressionQuality: 0.4)! as NSData
        photoBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        word = word + "\(photoBase64!)"
        dismiss(animated: true, completion:nil)
        
    }
    
    func imagePickerControllerDidCancel(_ Picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func mood1_controll(_ sender: Any) {
        mood.text = "mood1"
                if bt_mood2.isSelected {
                                         bt_mood2.isSelected = false
                                  bt_mood1.isSelected = true
                                      }
                                  else if bt_mood3.isSelected {
                                         bt_mood3.isSelected = false
                                  bt_mood1.isSelected = true
                                      }
                                  else if bt_mood4.isSelected {
                                         bt_mood4.isSelected = false
                                  bt_mood1.isSelected = true
                                      }
                    else if bt_mood5.isSelected {
                                                    bt_mood5.isSelected = false
                                             bt_mood1.isSelected = true
                                                 }
                                  else {
                                          bt_mood1.isSelected  = true
                                      }
    }
    @IBAction func mood2_controll(_ sender: Any) {
        mood.text = "mood2"
        if bt_mood1.isSelected {
                             bt_mood1.isSelected = false
                      bt_mood2.isSelected = true
                          }
                      else if bt_mood3.isSelected {
                             bt_mood3.isSelected = false
                      bt_mood2.isSelected = true
                          }
                      else if bt_mood4.isSelected {
                             bt_mood4.isSelected = false
                      bt_mood2.isSelected = true
                          }
        else if bt_mood5.isSelected {
                                        bt_mood5.isSelected = false
                                 bt_mood2.isSelected = true
                                     }
                      else {
                              bt_mood2.isSelected  = true
                          }
    }
    @IBAction func mood3_controll(_ sender: Any) {
        mood.text = "mood3"
        if bt_mood2.isSelected {
                             bt_mood2.isSelected = false
                      bt_mood3.isSelected = true
                          }
                      else if bt_mood1.isSelected {
                             bt_mood1.isSelected = false
                      bt_mood3.isSelected = true
                          }
                      else if bt_mood4.isSelected {
                             bt_mood4.isSelected = false
                      bt_mood3.isSelected = true
                          }
        else if bt_mood5.isSelected {
                                        bt_mood5.isSelected = false
                                 bt_mood3.isSelected = true
                                     }
                      else {
                              bt_mood3.isSelected  = true
                          }
    }
    @IBAction func mood4_controll(_ sender: Any) {
        mood.text = "mood4"
        if bt_mood2.isSelected {
                             bt_mood2.isSelected = false
                      bt_mood4.isSelected = true
                          }
                      else if bt_mood3.isSelected {
                             bt_mood3.isSelected = false
                      bt_mood4.isSelected = true
                          }
                      else if bt_mood1.isSelected {
                             bt_mood1.isSelected = false
                      bt_mood4.isSelected = true
                          }
        else if bt_mood5.isSelected {
                                        bt_mood5.isSelected = false
                                 bt_mood4.isSelected = true
                                     }
                      else {
                              bt_mood4.isSelected  = true
                          }
    }
    @IBAction func mood5_controll(_ sender: Any) {
        mood.text = "mood5"
        if bt_mood2.isSelected {
                             bt_mood2.isSelected = false
                      bt_mood5.isSelected = true
                          }
                      else if bt_mood3.isSelected {
                             bt_mood3.isSelected = false
                      bt_mood5.isSelected = true
                          }
                      else if bt_mood4.isSelected {
                             bt_mood4.isSelected = false
                      bt_mood5.isSelected = true
                          }
        else if bt_mood1.isSelected {
                                        bt_mood1.isSelected = false
                                 bt_mood5.isSelected = true
                                     }
                      else {
                              bt_mood5.isSelected  = true
                          }
    }
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        if segue.identifier == "addMoodcell"{
            let AddMoodViewController = segue.description as! Addmood_ViewController
            AddMoodViewController.Id = self.tdId
        }else{
            [print("add")]
        }
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

   @IBAction func btsavemood(_ sender: Any) {
         let url = "https://moodapi.000webhostapp.com/DBMoody/addmood.php?" //MARK: - host addmood
    
    let param : Parameters = [
        "mood":mood.text! as AnyObject,//MARK: - host addmood
        "ืnote":lb_note.text! as AnyObject,//MARK: - host addmood
        "img":word as AnyObject,//MARK: - host addmood
        ]
    AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
    switch response.result {
        case .success(_):
            let alert = UIAlertController(title: "เพิ่มข้อมูลอารมณ์เรียบร้อย", message: nil, preferredStyle: .alert)
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
    
    @IBAction func btLocation(_ sender: Any) {
       let autocompleteController = GMSAutocompleteViewController()
       autocompleteController.delegate = self
       present(autocompleteController, animated: true, completion: nil)
        
    }

}
extension Addmood_ViewController: GMSAutocompleteViewControllerDelegate {
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    ldname_location.text = String(place.name!)
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
