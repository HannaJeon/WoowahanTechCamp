//
//  ViewController.swift
//  BeaminFresh
//
//  Created by HannaJeon on 2017. 7. 18..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var foodsInfo = SerializationJson().makeModel()
    
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        cell.titleLabel.text = foodsInfo[indexPath.row].title
        cell.descriptionLabel.text = foodsInfo[indexPath.row].description
        if let normalPrice = foodsInfo[indexPath.row].normalPrice {
            cell.normalPriceLabel.text = normalPrice
        } else {
            cell.emptyNormalPrice()
        }
        if let salePrice = foodsInfo[indexPath.row].salePrice {
            cell.salePriceLabel.text = "\(salePrice)원"
        } else {
            cell.normalPriceLabel.text! += "원"
            cell.emptySalePrice()
        }
        if let badges = foodsInfo[indexPath.row].badge {
            for badge in badges {
                cell.makeBadgeLabel(badge: badge)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let test = Bundle.main.loadNibNamed("Test", owner: self, options: nil)?.first as! TestTableViewCell
        
        return test
    }
    
}

