//
//  ConfirmViewController.swift
//  ChickenCount
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var confirmNumberTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var overtimeMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewinit()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewinit() {
        sendButton.backgroundColor = UIColor.darkGray
        confirmButton.isEnabled = false
        overtimeMessageLabel.isHidden = true
    }

}
