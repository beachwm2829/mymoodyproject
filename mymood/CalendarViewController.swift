//
//  CalendarViewController.swift
//  mymood
//
//  Created by Manasawee Kaenampornpan on 2/10/2563 BE.
//  Copyright © 2563 Manasawee Kaenampornpan. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    var calendar:FSCalendar!
    var formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar = FSCalendar(frame: CGRect(x: 0.0, y: 60.0, width: self.view.frame.size.width, height: 300.0))
        calendar.scrollDirection = .vertical
        calendar.scope = .month
        self.view.addSubview(calendar)
        
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 17.0)
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18.0)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 16.0)
        
        calendar.allowsMultipleSelection = true
        
        calendar.dataSource = self
        calendar.delegate = self
    }
    
    //MARK:- Datasource
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date().addingTimeInterval((24*60*60)*5)
        
    }
    
    //MARK:- Delegate
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MMM-yyyy"
    }

}
