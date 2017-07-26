//
//  JoinViewController.swift
//  ChickenCount
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    let keyChain = KeyChain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        joinButton.addTarget(self, action: #selector(joinButtonAction), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkId(id: String) -> Bool {
        let _id = id.lowercased()
        
        if id.characters.count < 4 {
            return false
        }
        for character in _id.unicodeScalars {
            if (character < "0".unicodeScalars.first! || character > "9".unicodeScalars.first!) && (character < "a".unicodeScalars.first! || character > "z".unicodeScalars.first!) {
                return false
            }
        }
        
        return true
    }
    
    func checkPassword(id: String, password: String, passwordConfirm: String) -> Bool {
        if password != passwordConfirm || password.contains(id) || password.characters.count < 6 {
            return false
        } else {
            return true
        }
    }
    
    func joinButtonAction() {
        let id = idTextField.text!
        let password = passwordTextField.text!
        let passwordConfirm = passwordConfirmTextField.text!
        
        if id.isEmpty || password.isEmpty || passwordConfirm.isEmpty {
            UIAlertController().oneButtonAlert(target: self, title: "경고!!!!!", message: "빈칸을 채워주세요!!!")
        } else {
            if !checkId(id: id) && !checkPassword(id: id, password: password, passwordConfirm: passwordConfirm) {
                UIAlertController().oneButtonAlert(target: self, title: "경고!!!!!", message: "아이디와 비밀번호를 확인해주세요")
            } else {
                User.sharedInstance.set(id: id, password: password)
                keyChain.saveKeyChain(userInfo: User.sharedInstance)
                
                let confirmViewController = UIStoryboard.confirmStoryBoard.instantiateViewController(withIdentifier: "ConfirmViewController") as! ConfirmViewController
                self.present(confirmViewController, animated: true, completion: nil)
            }
        }
    }

}
