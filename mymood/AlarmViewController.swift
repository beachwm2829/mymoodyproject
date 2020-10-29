//
//  AlarmViewController.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 28/10/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var alId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func SaveAlram(_ sender: Any) {
        print(datePicker)
    }
    
}
