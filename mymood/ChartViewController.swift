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
    var name:[String] = ["mood1","mood2","mood3","mood4","mood5"]
    var mooddata:[(Date,[Double])] = []
//    override func viewWillAppear(_ animated: Bool) {
//        self.reloadInputViews()
//    }
    override func viewDidLoad() {
               let url = "http://project2.cocopatch.com/Moody/"
               let param : Parameters = ["u_id":self.ChartsId! as AnyObject]

               AF.request(url+"getMood.php?", method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) in
                   do {
                       //print("do")
                       let jsondata = try JSON(data: response.data!)
                       //print(jsondata)
                       let moodArray = jsondata["success"].arrayValue
                    print("count :> \(moodArray.count)")
                       for aMood in moodArray {
                            print(aMood)
                           let arId = aMood["m_id"].stringValue
                           let arMood = aMood["mood"].stringValue
                           let arDate = aMood["date"].stringValue
                           print("arId : \(arId)")
                           print("arMood : \(arMood)")
                           print("arDate : \(arDate)")
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                                        dateFormatter.dateFormat = "yyyy-MM-dd"
                                        let date = dateFormatter.date(from:arDate)!
                                        if arMood == "1"{
                                            self.summood1 = self.summood1+1
                        //                    print("summood2\(summood2)")
                                        }
                                        if arMood == "2"{
                                             self.summood2 = self.summood2+1
                        //                    print("summood3\(summood3)")
                                        }
                                        if arMood == "3"{
                                            self.summood3 = self.summood3+1
                        //                    print("summood4\(summood4)")
                                        }
                                        if arMood == "4"{
                                           self.summood4 = self.summood4+1
                        //                    print("summood5\(summood5)")
                                        }
                                        if arMood == "5"{
                                             self.summood5 = self.summood5+1
                        //                    print("summood1\(summood1)")
                                        }
                        self.mooddata.append((date,[self.summood1,self.summood2,self.summood3,self.summood4,self.summood5]))
                        print(self.mooddata)
                       }
                   }catch{}
                for i in 0..<self.mooddata.count{
                    self.setPieChart(dataPoints: self.name, values: self.mooddata[i].1 )
                        }
                print("summood1\(self.summood1)")
                print("summood2\(self.summood2)")
                print("summood3\(self.summood3)")
                print("summood4\(self.summood4)")
                print("summood5\(self.summood5)")
                print(self.mooddata)
                self.name.removeAll { $0 == "date" }
                print(self.name)
               }
        // Do any additional setup after loading the view.
    }
    @IBAction func Segment(_ sender: UISegmentedControl) {
        print("mooddata in sement =>\(self.mooddata)")
        switch sender.selectedSegmentIndex {
        case 0:
            for i in 0..<mooddata.count{
//                print("data:::\(data[i].0)")
                if Calendar.current.isDateInToday(mooddata[i].0){
                    print("data:::\(mooddata[i].0)")
                    setPieChart(dataPoints: name, values: mooddata[i].1 )
                }
//                setPieChart(dataPoints: name, values: data[i].1 )
            }
        case 1:
            //SetPieChart
                       for i in 0..<mooddata.count{
//                            print("data:::\(data[i].0)")
                            if Calendar.current.isDateInWeekend(mooddata[i].0){
                                print("data:month::\(mooddata[i].0)")
                                setPieChart(dataPoints: name, values: mooddata[i].1 )
                            }
            //                setPieChart(dataPoints: name, values: data[i].1 )
                        }//calendar.component(.month, from: date)


        case 2:
            let date = Date()
            let calendar = Calendar.current
            let fmt = DateFormatter()
            let month = fmt.string(from: date)
            print(month)
             for i in 0..<mooddata.count{
            //                            print("data:::\(data[i].0)")
                let components = calendar.dateComponents([.month], from: mooddata[i].0)
                let month = components.month
                print(month)
                                    }
        default:
            break
        }
    }
    func setPieChart(dataPoints: [String], values: [Double]) {
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = [#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)]
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        // 4. Assign it to the chart’s data
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
