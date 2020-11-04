//
//  ListCarerTableViewController.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 31/10/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Kingfisher
import SwiftyJSON

struct CarerModel :Decodable {
       let ID :String
       let name :String
       let image :String
   }


class ListCarerTableViewController: UITableViewController {
    
    var lcId:String?
    var imageCarer:UIImageView?
    var imag = ""
    
    var CarerData = [CarerModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CarerData.removeAll()
        self.getCarer()
    }

    func getCarer(){
         let url = "http://project2.cocopatch.com/Moody/"
         let param : Parameters = [
            "mode":"searchconf" as AnyObject,
            "u_id":self.lcId! as AnyObject
         ]

         AF.request(url+"searchUser.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
             do {
//                 print("do")
                 let jsondata = try JSON(data: response.data!)
//                 print(jsondata)
                 let CarerArray = jsondata["success"].arrayValue
                 for aCarer in CarerArray {
                     let idArr = aCarer["u_id"].stringValue
                     let nameArr = aCarer["name"].stringValue
                     let imgArr = aCarer["img"].stringValue
                     let CrData = CarerModel(ID: idArr, name: nameArr, image: imgArr)
                     self.CarerData.append(CrData)
                    print(" self.AssData\( self.CarerData)")

                 }
                 self.tableView.reloadData()
             }catch{
                 print("error")
             }
         }
     }
    
    func apiCarer(mode :String,cid :String, uid:String){
        let url = "http://project2.cocopatch.com/Moody/"
        let param : Parameters = [
           "mode":mode as AnyObject,
           "c_id":cid as AnyObject,
           "u_id":uid as AnyObject
        ]
        print("MODE : \(mode) || UID : \(uid) --> CID \(cid)")
        AF.request(url+"searchUser.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
            switch response.result {
            case .success(_):
                let alert = UIAlertController(title: "เพิ่มผู้ดูแลเรียบร้อย", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ตกลง", style: .cancel, handler:{(action) -> Void in
//                    self.navigationController!.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            case .failure(_):
                let alert = UIAlertController(title: "ข้อผิดพลาดเซิร์ฟเวอร์", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ลองอีกครั้ง", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CarerData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCarerTableViewCell
        let index = CarerData[indexPath.row]
        let url = URL(string: "http://project2.cocopatch.com/Moody/\(index.image)")
        cell?.img.kf.setImage(with: url)
        cell?.lbName.text = index.name
        
        cell?.actionBlockADD = {
            print("ADD \(index.ID)")
            self.apiCarer(mode: "add", cid: index.ID, uid: self.lcId!)
        }
        cell?.actionBlockDel = {
            print("DEL \(index.ID)")
            self.apiCarer(mode: "delete", cid: index.ID, uid: self.lcId!)
        }
        return cell!
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
