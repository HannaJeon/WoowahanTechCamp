//
//  ViewController.swift
//  ChickenCount
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var dDayLabel: UILabel!
    private let selectedDay = User.sharedInstance.chickenDate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dday = countDday(selectedDay: selectedDay) {
            drawView(dday: dday)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawView(dday: Int) {
        if dday == 0 {
            dDayLabel.text = "D-Day 입니다."
        } else {
            dDayLabel.text = String(describing: "D-\(dday)")
        }
    }
    
    func countDday(selectedDay: Date?) -> Int? {
        guard let selectedDay = selectedDay else { return nil }
        
        let calendar = Calendar.current
        let selecteDate = calendar.startOfDay(for: selectedDay)
        let todayDate = calendar.startOfDay(for: Date())
        let components = calendar.dateComponents([.day], from: todayDate, to: selecteDate)
        
        return components.day
    }

    
}

