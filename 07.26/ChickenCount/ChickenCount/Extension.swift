//
//  Extension.swift
//  ChickenCount
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

extension UIAlertController {
    func oneButtonAlert(target: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        target.present(alertController, animated: true, completion: nil)
    }
}

extension UIStoryboard {
    static let joinStoryBoard = UIStoryboard(name: "JoinView", bundle: nil)
    static let confirmStoryBoard = UIStoryboard(name: "ConfirmView", bundle: nil)
    static let datePickerStoryBoard = UIStoryboard(name: "DatePickerView", bundle: nil)
    static let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
}
