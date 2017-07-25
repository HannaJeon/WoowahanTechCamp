//
//  ViewController.swift
//  BeaminFresh
//
//  Created by HannaJeon on 2017. 7. 18..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import UIKit
import AlamofireImage

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let networking = Networking()
    var foodsInfoList = [[FoodInfo]]()
    var category = ["main", "course", "side", "soup"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networking.getJsonData(filePath: category)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailViewController
                controller.detailHash = foodsInfoList[indexPath.section][indexPath.row].detailHash
                controller.detailTitle = foodsInfoList[indexPath.section][indexPath.row].title
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return foodsInfoList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodsInfoList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        let foodInfo = foodsInfoList[indexPath.section][indexPath.row]
        
        cell.titleLabel.text = foodInfo.title
        cell.descriptionLabel.text = foodInfo.description
        
        if let normalPrice = foodInfo.normalPrice {
            cell.normalPriceLabel.text = normalPrice
        } else {
            cell.emptyNormalPrice()
        }
        if let salePrice = foodInfo.salePrice {
            cell.salePriceLabel.text = "\(salePrice)"
        } else {
            cell.emptySalePrice()
        }
        if let badges = foodInfo.badge {
            for badge in badges {
                cell.makeBadgeLabel(badge: badge)
            }
        }
        
        if let url = URL(string: foodInfo.image) {
            cell.foodImageView.af_setImage(withURL: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        let titleLabel = UILabel(frame: CGRect(x: self.view.frame.midX-25, y: 0, width: 50, height: 20))
        titleLabel.text = foodsInfoList[section].first?.type.returnDescription().title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 13)
        titleLabel.textColor = UIColor.lightGray
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(titleLabel)
        
        let descriptionLabel = UILabel(frame: CGRect(x: self.view.frame.minX+5, y: 30, width: self.view.frame.width-10, height: 30))
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(20))
        descriptionLabel.text = foodsInfoList[section].first?.type.returnDescription().description
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)
        
        return view
    }

}

