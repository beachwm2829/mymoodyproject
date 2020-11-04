//
//  AdviceTableViewController.swift
//  mymood
//
//  Created by macOS on 10/25/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class AdviceTableViewController: UITableViewController {
    
    struct AssessmentModel :Decodable {
           let nameAs :String
           let timeAs :String
           let dateAs :String
           let resultAs :String
       }
    
    var AdvId:String?
    var AssData = [AssessmentModel]()
    var AsData = [String]()
    
    var adviceArr = ["Q2=0":["1.แจ้งผลการคัดกรองโรคซึมเศร้าและให้สุขภาพจิตศึกษาเรื่องโรคซึมเศร้า","2.สามารถแจกเอกสารที่มีความรู้เรื่องโรคซึมเศร้าหรือสื่อสุขภาพจิตเรื่องโรคซึมเศร้า เช่น แผ่นพับ หนังสือ ฯลฯ","3.แนะนำให้สำรวจ/ประเมินโรคซึมเศร้าด้วย 2Q ด้วยตนเองเมื่อพบว่าผลมีแนวโน้มป่วยเป็นโรคซึมเศร้าให้ไปพบบุคลากรสาธารณสุขเพื่อประเมินโรคซึมเศร้าอีกครั้ง"],"Q2>0":["1.แจ้งผลการคัดกรองโรคซึมเศร้าและให้สุขภาพจิตศึกษาเรื่องโรคซึมเศร้า","2.สามารถแจกเอกสารที่มีความรู้เรื่องโรคซึมเศร้าหรือสื่อสุขภาพจิตเรื่องโรคซึมเศร้า เช่น แผ่นพับ หนังสือ ฯลฯ","3.แนะนำให้สำรวจ/ประเมินโรคซึมเศร้าด้วย 2Q ด้วยตนเองเมื่อพบว่าผลมีแนวโน้มป่วยเป็นโรคซึมเศร้าให้ไปพบบุคลากรสาธารณสุขเพื่อประเมินโรคซึมเศร้าอีกครั้ง"],"Q9=7-12":["1.    ประเมินการฆ่าตัวตายด้วยแบบประเมินการฆ่าตัวตาย 8 คำถาม (8Q)","2.แจ้งผลการประเมินโรคซึมเศร้าและการฆ่าตัวตายและให้สุขภาพจิตศึกษาโดยการทวนสอบความถูกต้องและพอเพียงในความรู้เรื่องโรคซึมเศร้าแล้วเพิ่มเติมในส่วนขาดหรือไม่ถูกต้อง อาจมอบเอกสารที่มีความรู้เรื่องโรคซึมเศร้าหรือสื่อสุขภาพจิตเรื่องโรคซึมเศร้า เช่น แผ่นพับ หนังสือ ฯลฯ","3.ประเมินว่า มีปัญหาด้านสังคมจิตใจหรือไม่ ถ้ามีควรให้การปรึกษาเพื่อแก้ไขปัญหาดังกล่าว","4.    แนะนำให้/ส่งต่อเพื่อรับการวินิจฉัยและตรวจรักษาเพิ่มเติมที่โรงพยาบาลชุมชนหรือโรงพยาบาลทั่วไปใกล้บ้านหลังพ้นโทษ"],"Q9=13-18":["1.ประเมินการฆ่าตัวตายด้วยแบบประเมินการฆ่าตัวตาย 8 คำถาม (8Q)","2.    แจ้งผลการประเมินโรคซึมเศร้าและการฆ่าตัวตายและให้สุขภาพจิตศึกษาโดยการทวนสอบความถูกต้องและพอเพียงในความรู้เรื่องโรคซึมเศร้าแล้วเพิ่มเติมในส่วนขาดหรือไม่ถูกต้อง อาจมอบเอกสารที่มีความรู้เรื่องโรคซึมเศร้าหรือสื่อสุขภาพจิตเรื่องโรคซึมเศร้า เช่น แผ่นพับ หนังสือ ฯลฯ","3.ประเมินว่า มีปัญหาด้านสังคมจิตใจหรือไม่ ถ้ามีควรให้การปรึกษาเพื่อแก้ไขปัญหาดังกล่าว","4.พิจารณาส่งพบจิตแพทย์เพื่อให้การวินิจฉัยและตรวจเพิ่มเติม"],"Q9>19":["1. ประเมินการฆ่าตัวตายด้วยแบบประเมินการฆ่าตัวตาย 8 คำถาม (8Q)","2.แจ้งผลการประเมินโรคซึมเศร้าและการฆ่าตัวตายและให้สุขภาพจิตศึกษาโดยการทวนสอบความถูกต้องและพอเพียงในความรู้เรื่องโรคซึมเศร้าแล้วเพิ่มเติมในส่วนขาดหรือไม่ถูกต้อง อาจมอบเอกสารที่มีความรู้เรื่องโรคซึมเศร้าหรือสื่อสุขภาพจิตเรื่องโรคซึมเศร้า เช่น แผ่นพับ หนังสือ ฯลฯ","3.ประเมินว่า มีปัญหาด้านสังคมจิตใจหรือไม่ถ้ามีควรให้การปรึกษาเพื่อแก้ไขปัญหา","4.พิจารณาส่งพบจิตแพทย์เพื่อให้การวินิจฉัยและตรวจเพิ่มเติม"],"Q8=1-8":["1.ประเมินความเจ็บป่วยทางจิตเวช ถ้ามีโรคซึมเศร้าให้ดูแลตามแนวทางที่กำหนดไว้","2.ควรปรึกษาหรือส่งต่อผู้ชำนาญด้านให้การปรึกษาหรือผู้ทำงานด้านสุขภาพจิตเพื่อให้การช่วยเหลือทางสังคมจิตใจ"],"Q8=9-16":["1.ให้การช่วยเหลือทางสังคมจิตใจช่วยแก้ไขปัญหาทุกข์ใจที่เร่งด่วน","2.ประเมินโรคจิตเวช หากมีโรคซึมเศร้าให้ดูแลรักษาตามแนวทางที่กำหนดไว้","3.ควรจัดให้มีผู้ดูแลอย่างใกล้ชิด และแนะนำญาติให้เข้าใจวิธีการช่วยเหลือเฝ้าระวังที่ถูกต้อง","4.ควรนัดติดตามเฝ้าระวังเพื่อให้การช่วยเหลือทางสังคมจิตใจอย่างต่อเนื่อง"],"Q8>17":["1.ควรรักษาในโรงพยาบาลและเฝ้าระวังอย่างใกล้ชิดตลอด 24 ชั่วโมงหรือพิจารณาส่งต่อโรงพยาบาลจิตเวช","2.ให้การช่วยเหลือทางสังคมจิตใจ และช่วยแก้ไขปัญหาทุกข์ใจที่เร่งด่วน","3.กรณีที่มีโรคซึมเศร้า ประเมินโรคซึมเศร้าด้วย 9Q ได้คะแนน > 13 ให้ส่งต่อโรงพยาบาลจิตเวชทันที"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ASSemment**")
        print(AdvId)
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
    override func viewWillAppear(_ animated: Bool) {
        AssData.removeAll()
        self.getAssessment()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssessmentCell", for: indexPath) as? Assessment_TableViewCell
        let index = AssData[indexPath.row]
        print("AssData ----->\(AssData)")
        cell?.nameAs.text = index.nameAs
        cell?.resultAs.text = index.resultAs
        cell?.timeAs.text = index.timeAs
        cell?.dateAs.text = index.dateAs
        
        let resultInt = Int(index.resultAs)
        
        for (name, advice) in adviceArr {
            if (index.nameAs == "Q2"){
                if(resultInt! >= 0){
                    if(name == "Q2=0"){
                        print("advice\(advice)")
                        cell?.textResultAs.text = advice.joined(separator:"\n")
                        
                        }
                }else if(name == "Q2>0"){
                    print("advice\(advice)")
                    cell?.textResultAs.text = advice.joined(separator:"\n")
                }
                    
                
            }else if (index.nameAs == "Q9"){
                if(resultInt! > 0 && resultInt! <= 12){
                    if(name == "Q9=7-12"){
                        print("advice\(advice)")
                        cell?.textResultAs.text = advice.joined(separator:"\n")
                    }
                }else if(resultInt! >= 13 && resultInt! <= 18){
                    if(name == "Q9=13-18"){
                        print("advice\(advice)")
                        cell?.textResultAs.text = advice.joined(separator:"\n")
                    }
                }
                else if(resultInt! >= 19){
                    if(name == "Q9>19"){
                        print("advice\(advice)")
                        cell?.textResultAs.text = advice.joined(separator:"\n")
                    }
                }
            }else if (index.nameAs == "Q8"){
                if(resultInt! >= 0 && resultInt! <= 8){
                    if(name == "Q8=1-8"){
                        print("advice\(advice)")
                        cell?.textResultAs.text = advice.joined(separator:"\n")
                    }
                    
                }else if(resultInt! >= 9 && resultInt! <= 16){
                    if(name == "Q8=9-16"){
                        print("advice\(advice)")
                        cell?.textResultAs.text = advice.joined(separator:"\n")
                    }
                }else if(resultInt! >= 17){
                    if(name == "Q8>17"){
                        print("advice\(advice)")
                        cell?.textResultAs.text = advice.joined(separator:"\n")
                    }
                }
            }
        }
        return cell!
        
    }
    func getAssessment(){
         let url = "http://project2.cocopatch.com/Moody/"
         let param : Parameters = ["u_id":self.AdvId! as AnyObject]

         AF.request(url+"getAssessment.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
             do {
//                 print("do")
                 let jsondata = try JSON(data: response.data!)
//                 print(jsondata)
                 let AssessmentArray = jsondata["success"].arrayValue
                 for aAssessment in AssessmentArray {
                     let nameAs = aAssessment["assessment"].stringValue
                     let resultAs = aAssessment["result"].stringValue
                     let dateAs = aAssessment["date"].stringValue
                     let timeAs = aAssessment["time"].stringValue
                     let AsData = AssessmentModel(nameAs: nameAs, timeAs: timeAs, dateAs: dateAs, resultAs: resultAs)
                     self.AssData.append(AsData)
                    print(" self.AssData\( self.AssData)")

                 }
                 self.tableView.reloadData()
             }catch{
                 print("error")
             }
         }
     }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 409
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AssData.count
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
