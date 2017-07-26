//
//  DatePickerViewController.swift
//  ChickenCount
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func confirm(selectedDate: Date) -> Bool {
        return selectedDate > Date() ? true : false
    }
    
    func doneButtonAction() {
        let selectedDate = datePicker.date
        if confirm(selectedDate: datePicker.date) {
            UIAlertController().oneButtonAlert(target: self, title: "경고!!!!!", message: "과거 날짜는 선택불가능합니다.")
        } else {
            User.sharedInstance.set(chickenDate: selectedDate)
            KeyChain().saveKeyChain(userInfo: User.sharedInstance)
            let mainViewController = UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            present(mainViewController, animated: false, completion: nil)
        }
    }

}
