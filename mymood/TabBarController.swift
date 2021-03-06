//
//  TabBarController.swift
//  
//
//  Created by Manasawee Kaenampornpan on 9/8/2563 BE.
//

import UIKit

class TabBarController: UITabBarController {

    var tbId :String?
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewControllers = viewControllers else{
            return
        }
        
        for viewControllers in viewControllers{
            print("viewControllers\(viewControllers)")
            if let mainNavigationController = viewControllers as? NavigationController{
                if let AddmoodViewController = mainNavigationController.viewControllers.first as? Addmood_ViewController{
                    AddmoodViewController.amId = self.tbId
                }
                if let settingTableViewController = mainNavigationController.viewControllers.first as? settingTableViewController{
                    print("setting this")
                    settingTableViewController.stId = self.tbId
                }
                if let MoodViewController = mainNavigationController.viewControllers.first as? MoodViewController{
                    MoodViewController.mvId = self.tbId
                }
                if let AssessmentViewController = mainNavigationController.viewControllers.first as? Assessment_TableViewController{
                    AssessmentViewController.asId = self.tbId
                }
                if let ChartViewController = mainNavigationController.viewControllers.first as? ChartViewController{
                    ChartViewController.ChartsId = self.tbId
                }
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
