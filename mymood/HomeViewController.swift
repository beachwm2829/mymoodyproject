//
//  HomeViewController.swift
//  
//
//  Created by Manasawee Kaenampornpan on 9/8/2563 BE.
//

import UIKit

class HomeViewController: UIViewController {

    var hvId :String?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hvID = \(hvId!)")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btAddmood(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toAddmood", sender: self)
    }
    
    @IBAction func btAddassess(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Resultcell", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "Resultcell"{
               let Result_q2_ViewController = segue.destination as! Result_q2_ViewController
               Result_q2_ViewController.q2Id = self.hvId
           }
           if segue.identifier == "toAddmood"{
               let NavigationController = segue.destination as! NavigationController
            NavigationController.ncId = self.hvId
           }

       }

}
