//
//  searchTableViewController.swift
//  mymood
//
//  Created by macOS on 10/23/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import Kingfisher
import AlamofireObjectMapper

class searchTableViewController: UITableViewController, UISearchBarDelegate {
    
    
    var searchId: String?
    var word: String?
    
    var u_id: String?
    
    struct listUsr : Decodable{
        let uId: String
        let User: String
        let Name: String
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var ListUsers = [listUsr]()
    var countryNameArr = [""]
    
    var searchCounty = [String]()
    var searching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        searchCounty = countryNameArr
        
        
        let url = "http://project2.cocopatch.com/Moody/"
        let param : Parameters = ["u_id":self.searchId as AnyObject,"mode":"search" as AnyObject]

        AF.request(url+"searchUser.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
            do {
                print("do")
                let jsondata = try JSON(data: response.data!)
                print(jsondata)
                let moodArray = jsondata["success"].arrayValue
                for aMood in moodArray {
                    let uId = aMood["u_id"].stringValue
                    let User = aMood["username"].stringValue
                    let Name = aMood["name"].stringValue
                    self.countryNameArr.append(aMood["username"].stringValue)
                    self.countryNameArr.append(aMood["name"].stringValue)
                    let listU = listUsr(uId: uId, User: User, Name: Name)
                    self.ListUsers.append(listU)
                    print("Name Name countryNameArr :\(self.countryNameArr)")
                }
                self.tableView.reloadData()
            }catch{
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchCounty.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")

        cell?.textLabel?.text = searchCounty[indexPath.row]
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = "http://project2.cocopatch.com/Moody/searchUser.php?"
        let param : Parameters = [
            "cid":searchId! as AnyObject,
            "mode":"add" as AnyObject,
            "u_id":u_id! as AnyObject,
            "status":"0" as AnyObject
        ]
        print(param)
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
        switch response.result {
            case .success(_):
                let alert = UIAlertController(title: "ส่งคำขอเพื่อดูแลเรียบร้อย", message: nil, preferredStyle: .alert)
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        searchCounty = []
        word = searchText
        print("Word :\(word)")
//        print("Name Name ListUser og:\(ListUsers)")
        if searchText == "" {
            searchCounty = countryNameArr
        }else{
            for i in ListUsers{
                let namearr = i.Name
                let userarr = i.User
                self.u_id = i.uId
                let finalString = [userarr, namearr].joined(separator: "\t")
                if finalString.lowercased().contains(searchText.lowercased()){
                    searchCounty.append(finalString)
                }
                print(i)
            }
        }
        self.tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel clicked")
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
