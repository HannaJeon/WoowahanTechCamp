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
    
    override func awakeFromNib() {
        foodImageInit()
        foodNameLabelsInit()
        addButtonsInit()
        buyButtonsInit()
        anotherSettingInit()
        stockLabelsInit()
        self.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
    }
    
    func stockLabelsInit() {
        stockLabels.forEach {
            if ($0.text?.isEmpty)! {
                $0.text = "0개"
            }
        }
    }
    
    func foodImageInit() {
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
            imageView.layer.borderWidth = 5
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.cornerRadius = 15
            imageView.clipsToBounds = true
        }
    }
    
    func foodNameLabelsInit() {
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
    }
    
    func addButtonsInit() {
        let viewController = ViewController(nibName: "viewController", bundle: nil)
        addButtons.forEach{ (button) in
            button.setTitle("추가", for: .normal)
            button.addTarget(viewController, action: #selector(viewController.addButtonAction(_:)), for: .touchUpInside)
        }
    }
    
    func buyButtonsInit() {
        let viewController = ViewController(nibName: "viewController", bundle: nil)
        
        buyButtons.forEach { (button) in
            button.setTitle("구매", for: .normal)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.isEnabled = false
            button.addTarget(viewController, action: #selector(viewController.buyFood(_:)), for: .touchUpInside)
        }
    }
    
    func anotherSettingInit() {
        let viewController = ViewController(nibName: "viewController", bundle: nil)

        plusCoin1000.addTarget(viewController, action: #selector(viewController.insert(_:)), for: .touchUpInside)
        plusCoin5000.addTarget(viewController, action: #selector(viewController.insert(_:)), for: .touchUpInside)
        plusCoin1000.setTitle("+1000", for: .normal)
        plusCoin5000.setTitle("+5000", for: .normal)
        balanceLabel.text = "잔액: 0원"
    }
}
