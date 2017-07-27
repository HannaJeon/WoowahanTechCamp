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
    lazy var someButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: 223, width: 300, height: 60))
        button.isHidden = true
        button.isEnabled = false
        button.setTitle("배달의민족앱으로 이동", for: .normal)
        button.backgroundColor = UIColor(red: 95/255, green: 192/255, blue: 189/255, alpha: 1)
        return button
    }()

    
    private let selectedDay = User.sharedInstance.chickenDate
    var touchCount = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dday = countDday(selectedDay: selectedDay) {
            drawView(dday: dday)
        }
        self.view.addSubview(someButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchCount += 1
        if touchCount == 10 {
            someButton.isHidden = false
            someButton.isEnabled = true
            touchCount = Int()
        }
    }

    func drawView(dday: Int) {
        if dday == 0 {
            dDayLabel.text = "D-Day 입니다."
            someButton.isHidden = false
            someButton.isEnabled = true
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

