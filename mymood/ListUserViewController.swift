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
        
        return 110
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
                    let name = aListUser["name"].stringValue
                    let sex = aListUser["gender"].stringValue
                    let birth = aListUser["birthdate"].stringValue
                    let disease = aListUser["disease"].stringValue
                    let adress = aListUser["adress"].stringValue
                    let mail = aListUser["email"].stringValue
                    let tel = aListUser["phone"].stringValue
                    let imgprofile = aListUser["img"].stringValue
                    
                    let List = ListUserModel(sickid: luId, name: name, sex: sex, birth: birth, disease: disease, adress: adress, mail: mail, tel: tel, imgprofile: imgprofile)
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
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let pm = storyboard?.instantiateViewController(withIdentifier: "popListUserViewController") as? popListUserViewController
//
//        let index = ListUsers[indexPath.row]
//               let url = URL(string: "http://project2.cocopatch.com/Moody/\(index.imgprofile)")
//        pm?.popListUserId = index.sickid
//        pm?.name = index.name
//        pm?.sex = index.sex
//        pm?.birth = index.birth
//        pm?.adress = index.disease
//        pm?.disease = index.adress
//        pm?.tel = index.mail
//        pm?.mail = index.tel
//        self.navigationController?.pushViewController(pm!, animated: true)
//    }
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
                    print(self.sickUserId)
                    popListUserViewController.popListUserId = self.sickUserId
                }
        if segue.identifier == "tosetting"{
                 let adminSettingViewController = segue.destination as! adminSettingViewController
                 print(self.amintbId)
            adminSettingViewController.adSId = self.amintbId
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
