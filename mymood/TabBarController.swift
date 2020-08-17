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
            if let mainNavigationController = viewControllers as? NavigationController{
                if let HomeViewController = mainNavigationController.viewControllers.first as? HomeViewController{
                    HomeViewController.hvId = self.tbId
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
