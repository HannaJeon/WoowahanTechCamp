//
//  ViewController.swift
//  Measurement
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertButton.addTarget(self, action: #selector(convertButtonTouched), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func convertButtonTouched() {
        let stringSpeed = textField.text
        guard (stringSpeed != nil) else { return }
        
        if let speed = Double(stringSpeed!) {
            var value = Measurement(value: speed, unit: UnitSpeed.kilometersPerHour)
            value.convert(to: UnitSpeed.milesPerHour)
            textLabel.text = String(describing: value)
        }
    }
}

