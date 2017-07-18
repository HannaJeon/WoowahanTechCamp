//
//  ViewController.swift
//  NetworkApp
//
//  Created by HannaJeon on 2017. 7. 18..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let jumpButton = UIButton()
    let imageView = UIImageView()
    let getButton = UIButton()
    let postButton = UIButton()
    let messageTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewinit()
        jumpButton.addTarget(self, action: #selector(jumpButtonAction(_:)), for: .touchUpInside)
        getButton.addTarget(self, action: #selector(getButtonAction), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(postButtonAction), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeViewby(reachability:)), name: NSNotification.Name("ReachabilityChanged"), object: Reachability.sharedInstance)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewinit() {
        self.view.backgroundColor = UIColor.black
        
        jumpButton.frame = CGRect(x: 130, y: 20, width: 130, height: 60)
        jumpButton.backgroundColor = UIColor.yellow
        jumpButton.setTitle("JUMP", for: .normal)
        jumpButton.setTitleColor(UIColor.blue, for: .normal)
        jumpButton.titleLabel?.font = UIFont(name: (jumpButton.titleLabel?.font.fontName)!, size: 30)
        self.view.addSubview(jumpButton)
        
        imageView.frame = CGRect(x: 10, y: jumpButton.frame.maxY+5, width: self.view.bounds.width-20, height: 300)
        imageView.image = #imageLiteral(resourceName: "sample")
        self.view.addSubview(imageView)
        
        getButton.frame = CGRect(x: imageView.frame.minX, y: imageView.frame.maxY+15, width: imageView.frame.width/2-15, height: jumpButton.frame.height)
        getButton.backgroundColor = UIColor(red: 143/255, green: 184/255, blue: 255/255, alpha: 1)
        getButton.setTitle("GET", for: .normal)
        getButton.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(getButton)
        
        postButton.frame = CGRect(x: imageView.frame.midX+10, y: getButton.frame.minY, width: getButton.frame.width, height: getButton.frame.height)
        postButton.backgroundColor = UIColor(red: 167/255, green: 170/255, blue: 169/255, alpha: 1)
        postButton.setTitle("POST", for: .normal)
        postButton.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(postButton)
        
        messageTextField.frame = CGRect(x: jumpButton.frame.minX, y: postButton.frame.maxY+20, width: jumpButton.frame.width, height: jumpButton.frame.height/2)
        messageTextField.backgroundColor = UIColor.white
        self.view.addSubview(messageTextField)
    }
    
    func jumpButtonAction(_ sender: UIButton) {
        UIView.animate(withDuration: 3, animations: {
            self.imageView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        }) { (complete) in
            if complete {
                self.imageView.frame = CGRect(x: 10, y: self.jumpButton.frame.maxY+5, width: self.view.bounds.width-20, height: 300)
            }
        }
    }
    
    func getButtonAction() {
        Networking().getJsonData()
    }
    
    func postButtonAction() {
        let jsonText = ["username": "한나", "text": messageTextField.text!]
        Networking().postMessage(message: jsonText)
    }
    
    func changeViewby(reachability notification: Notification) {
        guard let status = notification.userInfo as? [String:Bool] else { return }

        self.view.layer.borderWidth = 2
        if status["status"]! {
            self.view.layer.borderColor = UIColor.green.cgColor
        } else {
            self.view.layer.borderColor = UIColor.red.cgColor
        }
    }

}

