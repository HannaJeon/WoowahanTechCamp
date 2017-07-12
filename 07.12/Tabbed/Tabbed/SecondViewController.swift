//
//  SecondViewController.swift
//  Tabbed
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var secondViewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondViewButton.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonTouched() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }


}

