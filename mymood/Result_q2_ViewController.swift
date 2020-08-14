//
//  Result_q2_ViewController.swift
//  myAlamofire
//
//  Created by Manasawee Kaenampornpan on 30/4/2563 BE.
//  Copyright © 2563 iClassroom510-30. All rights reserved.
//

import UIKit

class Result_q2_ViewController: UIViewController {

    
    
    @IBOutlet weak var trueRadio_q2_a1: UIButton!
    @IBOutlet weak var falseRadio_q2_a1: UIButton!
    
    @IBOutlet weak var trueRadio_q2_a2: UIButton!
    @IBOutlet weak var falseRadio_q2_a2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkbox_f_a1(_ sender: UIButton) {
                if trueRadio_q2_a1.isSelected {
                       trueRadio_q2_a1.isSelected = false
                falseRadio_q2_a1.isSelected = true
                    } else {
                        falseRadio_q2_a1.isSelected  = true
                    }
         }
         
         @IBAction func checkbox_t_a1(_ sender: UIButton) {
                if falseRadio_q2_a1.isSelected {
                        falseRadio_q2_a1.isSelected = false
                 trueRadio_q2_a1.isSelected = true
                     } else {
                         trueRadio_q2_a1.isSelected  = true
                     }
             
         }
    @IBAction func checkbox_f_a2(_ sender: UIButton) {
           if trueRadio_q2_a2.isSelected {
                  trueRadio_q2_a2.isSelected = false
           falseRadio_q2_a2.isSelected = true
               } else {
                   falseRadio_q2_a2.isSelected  = true
               }
    }
    
    @IBAction func checkbox_t_a2(_ sender: UIButton) {
           if falseRadio_q2_a2.isSelected {
                   falseRadio_q2_a2.isSelected = false
            trueRadio_q2_a2.isSelected = true
                } else {
                    trueRadio_q2_a2.isSelected  = true
                }
        
    }
    
    @IBAction func b(_ sender: UIButton) {
        print("hello")
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
