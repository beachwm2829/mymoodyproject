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
        let img: String
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var ListUsers = [listUsr]()
    var countryNameArr = [listUsr]()
    
    var searchCounty = [listUsr]()
    var searching = false
    
    func reloadRows(at indexPaths: [IndexPath],
                    with animation: UITableView.RowAnimation){
        self.tableView.reloadData()
    }
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
                    let arImage = aMood["img"].stringValue
//                    self.countryNameArr.append(aMood["username"].stringValue)
//                    self.countryNameArr.append(aMood["name"].stringValue)
                    let listU = listUsr(uId: uId, User: User, Name: Name,img: arImage)
                    self.countryNameArr.append(listU)
                    self.ListUsers.append(listU)
                    print("Name Name countryNameArr :\(self.countryNameArr)")
//                    self.searchCounty = self.countryNameArr
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? searchUserTableViewCell
        let url = URL(string: "http://project2.cocopatch.com/Moody/\(searchCounty[indexPath.row].img)")

        cell?.name.text = searchCounty[indexPath.row].Name
        cell?.user.text = searchCounty[indexPath.row].User
        cell?.img.kf.setImage(with: url)
        return cell!
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 95
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = "http://project2.cocopatch.com/Moody/searchUser.php?"
        
        let param : Parameters = [
            "c_id":searchId! as AnyObject,
            "mode":"addconf" as AnyObject,
            "u_id":searchCounty[indexPath.row].uId as AnyObject
        ]
        print(param)
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).validate().responseString{ (response) in
        switch response.result {
            case .success(_):
                let alert = UIAlertController(title: "เพิ่มคำขอการติดตามเรียบร้อย", message: nil, preferredStyle: .alert)
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

        guard !searchText.isEmpty else {
            searchCounty = []
            tableView.reloadData()
            return
        }
        searchCounty = countryNameArr.filter({ listUsr -> Bool in
            listUsr.User.contains(searchText.lowercased()) || listUsr.Name.contains(searchText.lowercased())
            
        })
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
