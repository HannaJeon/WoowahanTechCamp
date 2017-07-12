//
//  DetailViewController.swift
//  Tabbed
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailViewButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        detailViewButton.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonTouched() {
        let detail2ViewController = self.storyboard?.instantiateViewController(withIdentifier: "detail2ViewController") as! Detail2ViewController
        self.navigationController?.pushViewController(detail2ViewController, animated: true)
    }
    
}
