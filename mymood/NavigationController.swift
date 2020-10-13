//
//  NavigationController.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 9/8/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    var ncId :String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Resultcell"{
             if let assessVc = segue.destination as? UINavigationController, let targetController = assessVc.topViewController as? Result_q2_ViewController {
                           targetController.q2Id = self.ncId
                       }
        }
        if segue.identifier == "toaddMood"{
         if let moodVc = segue.destination as? UINavigationController, let targetController = moodVc.topViewController as? Addmood_ViewController {
             targetController.amId = self.ncId
         }
        }
        if segue.identifier == "toListmood"{
         if let moodVc = segue.destination as? UINavigationController, let targetController = moodVc.topViewController as? MoodViewController {
            targetController.mvId = self.ncId
         }
        }
        if segue.identifier == "AsCell"{
         if let AssesVc = segue.destination as? UINavigationController, let targetController = AssesVc.topViewController as? Assessment_TableViewController {
            targetController.asId = self.ncId
         }
        }
//        if segue.identifier == "AsCell"{
//                if let AsVc = segue.destination as? UINavigationController, let targetController = AsVc.topViewController as? Assessment_TableViewController {
//                   targetController.asId = self.ncId
//                }
//               }
    }
    
    //AsCell
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
