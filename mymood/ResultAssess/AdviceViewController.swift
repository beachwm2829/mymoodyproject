//
//  AdviceViewController.swift
//  mymood
//
//  Created by macOS on 10/25/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class AdviceViewController: UIViewController {
    struct AssessmentModel :Decodable {
           let nameAs :String
           let timeAs :String
           let dateAs :String
           let resultAs :String
       }

    var AdvId:String?
    var AssData = [AssessmentModel]()
    var AsData = [String]()
    
    @IBOutlet weak var sumQ2: UILabel!
    @IBOutlet weak var sumQ9: UILabel!
    @IBOutlet weak var sumQ8: UILabel!
    
    
    @IBOutlet weak var adviceQ2: UILabel!
    @IBOutlet weak var adviceQ9: UILabel!
    @IBOutlet weak var adviceQ8: UILabel!
    
    var advice = ["1.แจ้งผลการคัดกรองโรคซึมเศร้าและให้สุขภาพจิตศึกษาเรื่องโรคซึมเศร้า","2.    สามารถแจกเอกสารที่มีความรู้เรื่องโรคซึมเศร้าหรือสื่อสุขภาพจิตเรื่องโรคซึมเศร้า เช่น แผ่นพับ หนังสือ ฯลฯ","3.แนะนำให้สำรวจ/ประเมินโรคซึมเศร้าด้วย 2Q ด้วยตนเอง เมื่อพบว่าผลมีแนวโน้มป่วยเป็นโรคซึมเศร้าให้ไปพบบุคลากรสาธารณสุขเพื่อประเมินโรคซึมเศร้าอีกครั้ง"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        AssData.removeAll()
        self.getAssessment()
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
                 self.reloadInputViews()
                
             }catch{
                 print("error")
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
