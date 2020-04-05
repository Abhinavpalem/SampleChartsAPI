//
//  ViewModel.swift
//  VertexDashBoard
//
//  Created by Abhinav reddy Palem on 4/2/20.
//  Copyright © 2020 Abhinav reddy Palem. All rights reserved.
//

import Foundation
import Charts

///Open/closed principle
class ViewModel {
    //Data Model of the ViewModel
    var pieChartData: PieChartData! = nil
    var barChartData: BarChartData! = nil
    
    var reloadData: (() -> Void)?
    
    private let parties = ["Party A", "Party B", "Party C", "Party D", "Party E", "Party F",
                           "Party G", "Party H", "Party I", "Party J", "Party K", "Party L",
                           "Party M", "Party N", "Party O", "Party P", "Party Q", "Party R",
                           "Party S", "Party T", "Party U", "Party V", "Party W", "Party X",
                           "Party Y", "Party Z"]
    
    init() {
        setupCharData()
    }
    
    private func setupCharData() {
        setPieDataCount(0)
        setBarDataCount(3)
    }
    
    func setBarDataCount(_ count: Int) {
        let range = 100.0
        let start = 1
        
        let yVals = (start..<start+count+1).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(UInt32(mult)))
            if arc4random_uniform(100) < 25 {
                return BarChartDataEntry(x: Double(i), y: val, icon: UIImage(named: "icon"))
            } else {
                return BarChartDataEntry(x: Double(i), y: val)
            }
        }
        
        let set1: BarChartDataSet = BarChartDataSet(entries: yVals, label: "The year 2020")
        set1.colors = ChartColorTemplates.material()
        set1.drawValuesEnabled = false
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
        data.barWidth = 0.9
        self.barChartData = data
        reloadData?()
    }
    
    func setPieDataCount(_ count: Int) {
        let range: UInt32 = 10
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
                                     label: parties[i % parties.count],
                                     icon: nil)
        }
        
        let set = PieChartDataSet(entries: entries, label: "Election Results")
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        
        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.black)
        
        self.pieChartData = data
        reloadData?()
    }
}
