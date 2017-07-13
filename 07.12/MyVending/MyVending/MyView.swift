//
//  MyView.swift
//  MyVending
//
//  Created by woowabrothers on 2017. 7. 13..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class MyView: UIView {
    
    @IBOutlet var addButtons: [UIButton]!
    @IBOutlet var foodImages: [UIImageView]!
    @IBOutlet var buyButtons: [UIButton]!
    @IBOutlet weak var plusCoin1000: UIButton!
    @IBOutlet weak var plusCoin5000: UIButton!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet var stockLabels: [UILabel]!
    @IBOutlet var foodNameLabels: [UILabel]!
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    override func layoutSubviews() {
        let viewController = storyBoard.instantiateViewController(withIdentifier: "viewController") as! ViewController
        
        for imageView in foodImages {
            switch imageView.tag {
            case 1:
                imageView.image = #imageLiteral(resourceName: "pizza")
            case 2:
                imageView.image = #imageLiteral(resourceName: "hamburger")
            case 3:
                imageView.image = #imageLiteral(resourceName: "dduck")
            case 4:
                imageView.image = #imageLiteral(resourceName: "bossam")
            case 5:
                imageView.image = #imageLiteral(resourceName: "chicken")
            default:
                break
            }
        }
        
        for foodName in foodNameLabels {
            switch foodName.tag {
            case 1:
                foodName.text = "피자헛"
            case 2:
                foodName.text = "맥도날드"
            case 3:
                foodName.text = "엽기떡볶이"
            case 4:
                foodName.text = "원할머니보쌈"
            case 5:
                foodName.text = "교촌치킨"
            default:
                break
            }
        }
        
        addButtons.forEach{ (button) in
            button.setTitle("추가", for: .normal)
            button.addTarget(viewController, action: #selector(viewController.addButtonAction(_:)), for: .touchUpInside)
        }
        buyButtons.forEach { (button) in
            button.setTitle("구매", for: .normal)
            button.setTitleColor(UIColor.red, for: .normal)
        }
        plusCoin1000.setTitle("+1000", for: .normal)
        plusCoin5000.setTitle("+5000", for: .normal)
        balanceLabel.text = "잔액: 0원"
        stockLabels.forEach{ $0.text = "0개" }
    }
}
