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
    var foodsInfoList = SerializationJson().makeModel(filenames: ["main", "course", "side", "soup"])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return foodsInfoList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let foods = foodsInfoList[section].flatMap { $0.value }
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        let foods = foodsInfoList.flatMap { Array($0.values) }
        
        cell.titleLabel.text = foods[indexPath.section][indexPath.row].title
        cell.descriptionLabel.text = foods[indexPath.section][indexPath.row].description
        if let normalPrice = foods[indexPath.section][indexPath.row].normalPrice {
            cell.normalPriceLabel.text = normalPrice
        } else {
            cell.emptyNormalPrice()
        }
        if let salePrice = foods[indexPath.section][indexPath.row].salePrice {
            cell.salePriceLabel.text = "\(salePrice)원"
        } else {
            cell.normalPriceLabel.text! += "원"
            cell.emptySalePrice()
        }
        if let badges = foods[indexPath.section][indexPath.row].badge {
            for badge in badges {
                cell.makeBadgeLabel(badge: badge)
            }
        }
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

