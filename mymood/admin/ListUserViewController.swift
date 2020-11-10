//
//  ListUserViewController.swift
//  mymood
//
//  Created by macOS on 10/16/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import Kingfisher
import AlamofireObjectMapper

class ListUserViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var amintbId:String?
    var sickUserId:String = "1"
    
    struct ListUserModel :Decodable {
        let sickid :String
        let user :String
        let name :String
        let sex :String
        let birth :String
        let disease :String
        let adress :String
        let mail :String
        let tel :String
        let imgprofile:String
           
       }
    var ListUserData = [[String:AnyObject]]()
    var ListUsers = [ListUserModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("sickUserId   =>\(self.sickUserId)")
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 99
    }
    override func viewWillAppear(_ animated: Bool) {
        self.ListUsers.removeAll()
        self.getListUser()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListUsers.count
    }

    
    func getListUser(){
        
        let url = "http://project2.cocopatch.com/Moody/"
        let param : Parameters = ["u_id":self.amintbId! as AnyObject]

        AF.request(url+"getListUser.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
            do {
                //print("do")
                let jsondata = try JSON(data: response.data!)
//                print(jsondata)
                let ListUserArray = jsondata["success"].arrayValue
                for aListUser in ListUserArray {
                    let luId = aListUser["u_id"].stringValue
                    let user = aListUser["username"].stringValue
                    let name = aListUser["name"].stringValue
                    let sex = aListUser["gender"].stringValue
                    let birth = aListUser["birthdate"].stringValue
                    let disease = aListUser["disease"].stringValue
                    let adress = aListUser["adress"].stringValue
                    let mail = aListUser["email"].stringValue
                    let tel = aListUser["phone"].stringValue
                    let imgprofile = aListUser["img"].stringValue
                    
                    let List = ListUserModel(sickid: luId, user: user, name: name, sex: sex, birth: birth, disease: disease, adress: adress, mail: mail, tel: tel, imgprofile: imgprofile)
                    self.ListUsers.append(List)
//                    print("ListUsers\(self.ListUsers)")
                }
                self.tableView.reloadData()
            }catch{
                self.tableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListUsercell", for: indexPath) as?  ListUserTableViewCell
        
//        print("this here !!")
        let index = ListUsers[indexPath.row]
        let url = URL(string: "http://project2.cocopatch.com/Moody/\(index.imgprofile)")
//        self.sickUserId = index.sickid
//        print("sickUserId\(sickUserId)")
        cell?.lbname.text = index.name
        cell?.lbuser.text = index.user
        cell?.imgProfile.kf.setImage(with: url)
        print("url\(url)")
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = ListUsers[indexPath.row]
        
        sickUserId = index.sickid
        print("sickUserId\(sickUserId)")
        self.performSegue(withIdentifier: "toDetailUser", sender: self)
        
    }
    @IBAction func tossearching(_ sender: Any) {
       
        self.performSegue(withIdentifier: "searchCell", sender: self)
        
    }
    @IBAction func tosetting(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: "ต้องการออกจากระบบหรือไม่?", preferredStyle: UIAlertController.Style.actionSheet)
        let logOutButton = UIAlertAction(title: "ออกจากระบบ", style: UIAlertAction.Style.destructive){(select) in
        self.dismiss(animated: true, completion: nil)
        }
        let settingButton = UIAlertAction(title: "จัดการข้อมูลส่วนตัว", style: UIAlertAction.Style.default){(select) in
            self.performSegue(withIdentifier: "tosetting", sender: self)
        }
        let cancleButton = UIAlertAction(title: "ยกเลิก", style: UIAlertAction.Style.cancel){(select) in}
            actionSheet.addAction(settingButton)
            actionSheet.addAction(logOutButton)
            actionSheet.addAction(cancleButton)
            self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailUser"{
            let popListUserViewController = segue.destination as! popListUserViewController
            popListUserViewController.popListUserId = self.sickUserId
            popListUserViewController.amId = self.sickUserId
        }
        if segue.identifier == "tosetting"{
            let adminSettingViewController = segue.destination as! adminSettingViewController
            print(self.amintbId)
            adminSettingViewController.adSId = self.amintbId
        }
        if segue.identifier == "searchCell"{
            let searchTableViewController = segue.destination as! searchTableViewController
            print(self.amintbId)
            searchTableViewController.searchId = self.amintbId
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let user = ListUsers[indexPath.row]
            let url = "http://project2.cocopatch.com/Moody/"
            let param : Parameters = [
                "c_id":user.sickid as AnyObject,
                "mode":"delete" as AnyObject
            ]
            AF.request(url+"Updatemember.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
                switch response.result {
                    case .success(_):
                        let alert = UIAlertController(title: "ลบสมาชิกเรียบร้อย", message: nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "ตกลง", style: .cancel, handler:{ [self](action) -> Void in
                            self.ListUsers.removeAll()
                            self.getListUser()
                            self.tableView.reloadData()
                        }))
                        self.present(alert, animated: true, completion: nil)
                case .failure(_):
                    let alert = UIAlertController(title: "ไม่สามารถลบสมาชิกได้", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ตกลง", style: .cancel, handler:{(action) -> Void in
                        self.tableView.reloadData()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                self.tableView.reloadData()
            }
            
        }
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
