//
//  add_activityViewController.swift
//  mymood
//
//  Created by macOS on 9/1/20.
//  Copyright © 2020 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit

class add_activityViewController: UIViewController {
    
    var activity:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func bt_shopping(_ sender: UIButton) {
        activity = "online-shopping"
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveActivity"), object: self)
        self.dismiss(animated: true)
    }
    @IBAction func bt_music(_ sender: Any) {
        activity = "entertainment"
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveActivity"), object: self)
        self.dismiss(animated: true)
    }
    @IBAction func bt_yoga(_ sender: Any) {
        activity = "yoga"
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveActivity"), object: self)
        self.dismiss(animated: true)
    }
    @IBAction func bt_social(_ sender: Any) {
        activity = "social-media"
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveActivity"), object: self)
        self.dismiss(animated: true)
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
