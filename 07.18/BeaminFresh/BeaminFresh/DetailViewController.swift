//
//  DetailViewController.swift
//  BeaminFresh
//
//  Created by HannaJeon on 2017. 7. 19..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailHash = String()
    var foodDetail = FoodDetail()
    let networking = Networking()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        
        networking.getFoodDetail(hash: detailHash)
        NotificationCenter.default.addObserver(self, selector: #selector(finishedGetFoodDetail(_:)), name: NSNotification.Name("getFoodDetail"), object: networking)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func finishedGetFoodDetail(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String:FoodDetail] {
            foodDetail = userInfo["foodDetail"]!
        }
        print(foodDetail)
    }

}
