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
    @IBOutlet weak var warnningMessageLabel: UILabel!
    
    private var randomNumber: String!
    private var phoneNumber: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewinit()
        
        sendButton.addTarget(self, action: #selector(sendButtonAction), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(startCountTime), name: NSNotification.Name("startCountTime"), object: nil)
    }
    
    func sendButtonAction() {
        phoneNumber = phoneNumberTextField.text!
        randomNumber = String(arc4random_uniform(899999) + 100000)
        print(randomNumber)
        Networking().postConfirm(message: ["username":phoneNumber, "text":randomNumber])
        reloadView()
        warnningMessageLabel.isHidden = true
    }
    
    func confirmButtonAction() {
        if confirmNumberTextField.text != randomNumber {
            viewinit()
            warnningMessageLabel.isHidden = false
            warnningMessageLabel.text = "인증에 실패하셨습니다. 다시 시도해주세요."
        } else {
            User.sharedInstance.set(phoneNumber: phoneNumber)
            KeyChain().saveKeyChain(userInfo: User.sharedInstance)
            let datePickerViewController = UIStoryboard.datePickerStoryBoard.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
            present(datePickerViewController, animated: false, completion: nil)
        }
       
    }
    
    func startCountTime() {
        viewinit()
        warnningMessageLabel.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewinit() {
        sendButton.isEnabled = true
        confirmButton.isEnabled = false
        warnningMessageLabel.isHidden = true
        confirmNumberTextField.text = nil
        sendButton.backgroundColor = UIColor.darkGray
        confirmButton.backgroundColor = UIColor.lightGray
    }
    
    func reloadView() {
        sendButton.isEnabled = false
        confirmButton.isEnabled = true
        sendButton.backgroundColor = UIColor.lightGray
        confirmButton.backgroundColor = UIColor.darkGray
        warnningMessageLabel.text = "시간이 초과되었습니다.  인증번호를 재전송 해주세요."
    }

}
