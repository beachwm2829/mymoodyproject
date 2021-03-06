//
//  ChartViewController.swift
//  myChart
//
//  Created by PHICHITCHAI on 4/9/2562 BE.
//  Copyright © 2562 Nopparit Srithiang. All rights reserved.
//

import UIKit
import Charts
import CoreData
import Alamofire
import SwiftyJSON


class ChartViewController: UIViewController {
    
    @IBOutlet weak var PieChart: PieChartView!
   
    var ChartsId :String?

    var summood1:Double = 0.0
    var summood2:Double = 0.0
    var summood3:Double = 0.0
    var summood4:Double = 0.0
    var summood5:Double = 0.0

    var lbDatemood:String = ""
    var name = [String]()
    var mooddata:[[Double]] = []
    var mooddataToday:[Double] = []

    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadInputViews()
        checkDate(typeDate: "today")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func checkDate(typeDate:String){
        self.summood1 = 0.0
        self.summood2 = 0.0
        self.summood3 = 0.0
        self.summood4 = 0.0
        self.summood5 = 0.0
        let url = "http://project2.cocopatch.com/Moody/"
        let param : Parameters = ["u_id":self.ChartsId! as AnyObject]

        AF.request(url+"getMood.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
            do {
                let jsondata = try JSON(data: response.data!)
                let moodArray = jsondata["success"].arrayValue
                for aMood in moodArray {
                    let arId = aMood["m_id"].stringValue
                    var arMood = aMood["mood"].stringValue
                    let arDate = aMood["date"].stringValue
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en")
                    dateFormatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date = dateFormatter.date(from:arDate)!
                    print(date)
                    if(typeDate == "today") {
                            if(Calendar.current.isDateInToday(date)) {
                                if arMood == "1"{
                                    arMood = "โคตรมีความสุข"
                                    self.summood1 = self.summood1+1
//                                    self.mooddataToday.append(self.summood1)
                                }
                                if arMood == "2"{
                                    arMood = "มีความสุข"
                                    self.summood2 = self.summood2+1
                                    print(self.summood2)
//                                    self.mooddataToday.append(self.summood2)

                                }
                                if arMood == "3"{
                                    arMood = "เฉยชา"
                                    self.summood3 = self.summood3+1
//                                    self.mooddataToday.append(self.summood3)
                                }
                                if arMood == "4"{
                                    arMood = "เบื่อ"
                                    self.summood4 = self.summood4+1
//                                    self.mooddataToday.append(self.summood4)

                                }
                                if arMood == "5"{
                                    arMood = "โกรธ"
                                    self.summood5 = self.summood5+1
//                                    self.mooddataToday.append(self.summood5)

                                }
                             self.name.append(arMood)
                             self.mooddata.append([self.summood1,self.summood2,self.summood3,self.summood4,self.summood5])
                            }
                        } else if(typeDate == "month") {
                            let calendar = Calendar.current
                            let monthNow = Calendar.current.component(.month, from: Date())
                            let components = calendar.dateComponents([.month], from: date)
                            let month:Int = components.month!
                            if(monthNow == month) {
                                print(monthNow)
                                if arMood == "1"{
                                    arMood = "โคตรมีความสุข"
                                    self.summood1 = self.summood1+1
                                }
                                if arMood == "2"{
                                    arMood = "มีความสุข"
                                    self.summood2 = self.summood2+1
                                }
                                if arMood == "3"{
                                    arMood = "เฉยชา"
                                    self.summood3 = self.summood3+1
                                }
                                if arMood == "4"{
                                    arMood = "เบื่อ"
                                    self.summood4 = self.summood4+1
                                }
                                if arMood == "5"{
                                    arMood = "โกรธ"
                                    self.summood5 = self.summood5+1
                                }
                             self.name.append(arMood)
                             self.mooddata.append([self.summood1,self.summood2,self.summood3,self.summood4,self.summood5])
                            }
                        } else if(typeDate == "year") {
                            let calendar = Calendar.current
                            let yearNow = Calendar.current.component(.year, from: Date())
                            let components = calendar.dateComponents([.year], from: date)
                            let year:Int = components.year!
                            if(yearNow == year) {
                                print(yearNow)
                                if arMood == "1"{
                                    arMood = "โคตรมีความสุข"
                                    self.summood1 = self.summood1+1
                                }
                                if arMood == "2"{
                                    arMood = "มีความสุข"
                                    self.summood2 = self.summood2+1
                                }
                                if arMood == "3"{
                                    arMood = "เฉยชา"
                                    self.summood3 = self.summood3+1
                                }
                                if arMood == "4"{
                                    arMood = "เบื่อ"
                                    self.summood4 = self.summood4+1
                                }
                                if arMood == "5"{
                                    arMood = "โกรธ"
                                    self.summood5 = self.summood5+1
                                }
                             self.name.append(arMood)
                             self.mooddata.append([self.summood1,self.summood2,self.summood3,self.summood4,self.summood5])
                            }
                        }
                    }
            }catch{}
            let namee = Array(Set(self.name))
            print(namee)
//            if(typeDate == "today") {
//                print("mooddataToday : \(self.mooddataToday)")
//                self.setPieChart(dataPoints: namee, values: self.mooddataToday)
//            }else{
                print(self.mooddata)
                if(self.mooddata.last != nil){
                    let countmood = self.mooddata.count - 1
                    print("count \(self.mooddata.last?.count)")
                    print("last \(self.mooddata.last)")
                    var i = 0
                    while i < (self.mooddata.last?.count)! {
                        if (self.mooddata.last![i]) == 0.0 {
                            self.mooddata[countmood].remove(at: i)
                            i = 0
                        }else {
                            i += 1
                        }
                        
                    }
                    print("Mood Final is \(self.mooddata.last)")
                    self.setPieChart(dataPoints: namee, values: self.mooddata[countmood])
                }
//            }
            self.name.removeAll { $0 == "date" }
        }
    }
    @IBAction func Segment(_ sender: UISegmentedControl) {
//        print("mooddata in sement =>\(self.mooddata)")
        switch sender.selectedSegmentIndex {
        case 0:
            self.name.removeAll()
            self.mooddataToday.removeAll()
            checkDate(typeDate: "today")
        case 1:
            self.name.removeAll()
            self.mooddata.removeAll()
            checkDate(typeDate: "month")
        case 2:
            self.name.removeAll()
            self.mooddata.removeAll()
            checkDate(typeDate: "year")
        default:
            break
        }
    }
    func setPieChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        var colors: [UIColor] = []

        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
            
            if(dataPoints[i] == "โคตรมีความสุข") {
                colors.append(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))
            } else if(dataPoints[i] == "มีความสุข") {
                colors.append(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
            } else if(dataPoints[i] == "เฉยชา") {
                colors.append(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
            } else if(dataPoints[i] == "เบื่อ") {
                colors.append(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
            } else if(dataPoints[i] == "โกรธ") {
                colors.append(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
            }

        }
        
        let legend = PieChart.legend
        legend.horizontalAlignment = .center
        legend.verticalAlignment = .bottom
//        legend.orientation = .horizontal
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colors
               
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        PieChart.data = pieChartData

    }
//    func setBarchart(dataPoints: [String], values: [[Double]])  {
//        var allBarChartDataSets: [BarChartDataSet] = [BarChartDataSet]()
//        let color = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)]
//        for i in 0..<dataPoints.count{
//            var dataEntries: [ChartDataEntry] = []
//            for j in 0..<values[0].count{
//                let dataEntry = ChartDataEntry(x: Double(j+1) , y: values[i][j])
//                dataEntries.append(dataEntry)
//            }
//            let BarChartDataSet: BarChartDataSet = BarChartDataSet(entries: dataEntries, label: dataPoints[i])
//            BarChartDataSet.colors = [color[i]]
//            allBarChartDataSets.append(BarChartDataSet)
//        }
//        let barChartData = BarChartData(dataSets: allBarChartDataSets)

//    }
  


}
