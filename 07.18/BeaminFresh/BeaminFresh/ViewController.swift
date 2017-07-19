//
//  ViewController.swift
//  BeaminFresh
//
//  Created by HannaJeon on 2017. 7. 18..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var testArray = ["1","2","3","4"]
    @IBOutlet weak var tableView: UITableView!
    let networking = Networking()
    var foodsInfoList = [[FoodInfo]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networking.getJsonData(filePath: ["main", "course", "side", "soup"])
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(changedViewby(reachability:)), name: NSNotification.Name("ReachabilityChanged"), object: Reachability.sharedInstance)
        NotificationCenter.default.addObserver(self, selector: #selector(changedFoodInfo(_:)), name: NSNotification.Name("changedFoodInfo"), object: networking)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changedViewby(reachability notification: Notification) {
        guard let status = notification.userInfo as? [String:Bool] else { return }
        
        self.view.layer.borderWidth = 2
        if status["status"]! {
            self.view.layer.borderColor = UIColor.green.cgColor
        } else {
            self.view.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func changedFoodInfo(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String:[FoodInfo]] {
            foodsInfoList.append(userInfo["foodInfo"]!)
            tableView.reloadData()
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return foodsInfoList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodsInfoList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        cell.titleLabel.text = foodsInfoList[indexPath.section][indexPath.row].title
        cell.descriptionLabel.text = foodsInfoList[indexPath.section][indexPath.row].description
        if let normalPrice = foodsInfoList[indexPath.section][indexPath.row].normalPrice {
            cell.normalPriceLabel.text = normalPrice
        } else {
            cell.emptyNormalPrice()
        }
        if let salePrice = foodsInfoList[indexPath.section][indexPath.row].salePrice {
            cell.salePriceLabel.text = "\(salePrice)"
        } else {
            cell.emptySalePrice()
        }
        if let badges = foodsInfoList[indexPath.section][indexPath.row].badge {
            for badge in badges {
                cell.makeBadgeLabel(badge: badge)
            }
        }
        
        cell.foodImageView.image = networking.getCacheImage(filename: foodsInfoList[indexPath.section][indexPath.row].detailHash)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return testArray[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

}

