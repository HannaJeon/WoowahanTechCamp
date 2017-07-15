//
//  ViewController.swift
//  MyVending
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var vendingMachine = VendingMachine()
    var buttonTag = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkStockInit()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNoti), name: NSNotification.Name(rawValue: "addProduct"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkStockInit() {
        let stock = vendingMachine.checkStock()
        let key = stock.map { $0.key }

        for i in key {
            stock.forEach { (food: (key: String, value: [String : Int])) in
                if i == food.key {
                    sendDataToLabel(stock: [food.key : food.value.values.first!])
                }
            }
        }
    }
    
    func addButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            vendingMachine.addProduct(food: Pizza(restaurant: "피자헛", capacity: 10, price: 20000, foodName: "페퍼로니피자", extraCheese: false))
        case 2:
            vendingMachine.addProduct(food: Hamberger(restaurant: "맥도날드", capacity: 10, price: 4000, foodName: "불고기버거", upgradeSize: true, withFrenchFry: true))
        case 3:
            vendingMachine.addProduct(food: KoreanFood(restaurant: "엽기떡볶이", capacity: 10, price: 15000, foodName: "엽기떡볶이", spicyDegree: 30))
        case 4:
            vendingMachine.addProduct(food: KoreanFood(restaurant: "원할머니보쌈", capacity: 10, price: 25000, foodName: "보쌈", spicyDegree: 0))
        case 5:
            vendingMachine.addProduct(food: Chicken(restaurant: "교촌치킨", capacity: 10, price: 18000, foodName: "양념치킨", spicy: true, withBeer: true))
        default:
            break
        }
        buttonTag = sender.tag
    }
    
    func receiveNoti(_ notification: Notification) {
        if let stock = notification.userInfo as? [String:Int] {
            sendDataToLabel(stock: stock)
        }
    }
    
    func sendDataToLabel(stock: [String:Int]) {
        let view = self.view as! MyView

        view.stockLabels.forEach { (label) in
            switch label.tag {
            case 1:
                guard let value = stock["피자헛"] else { return }
                label.text = String(describing: value)
            case 2:
                guard let value = stock["맥도날드"] else { return }
                label.text = String(describing: value)
            case 3:
                guard let value = stock["엽기떡볶이"] else { return }
                label.text = String(describing: value)
            case 4:
                guard let value = stock["원할머니보쌈"] else { return }
                label.text = String(describing: value)
            case 5:
                guard let value = stock["교촌치킨"] else { return }
                label.text = String(describing: value)
            default:
                break
            }
        }
    }
    
    func insert(_ sender: UIButton) {
        let view = self.view as! MyView
        var value: (foodList: [String:[String]], balance: Int)
        
        if sender.tag == 1 {
            value = vendingMachine.checkAblePurchase(money: 1000)
        } else {
            value = vendingMachine.checkAblePurchase(money: 5000)
        }

        checkAbleFood(foodList: value.foodList)
        view.balanceLabel.text = String("잔액: \(value.balance)원")
    }
    
    func checkAbleFood(foodList: [String:[String]]) {
        let view = self.view as! MyView
        
        view.buyButtons.forEach { (button) in
            button.setTitleColor(UIColor.gray, for: .normal)
            button.isEnabled = false
        }
        
        if !foodList.isEmpty {
            foodList.forEach({ (food: (key: String, value: [String])) in
                switch food.key {
                case "피자헛":
                    view.buyButtons[0].setTitleColor(UIColor.red, for: .normal)
                    view.buyButtons[0].isEnabled = true
                case "맥도날드":
                    view.buyButtons[1].setTitleColor(UIColor.red, for: .normal)
                    view.buyButtons[1].isEnabled = true
                case "엽기떡볶이":
                    view.buyButtons[2].setTitleColor(UIColor.red, for: .normal)
                    view.buyButtons[2].isEnabled = true
                case "원할머니보쌈":
                    view.buyButtons[3].setTitleColor(UIColor.red, for: .normal)
                    view.buyButtons[3].isEnabled = true
                case "교촌치킨":
                    view.buyButtons[4].setTitleColor(UIColor.red, for: .normal)
                    view.buyButtons[4].isEnabled = true
                default:
                    break
                }
            })
        }
    }
    
    func buyFood(_ sender: UIButton) {
        let view = self.view as! MyView
        var value: (stock: [String:Int], foodList: [String:[String]], balance: Int)? = nil
        
        switch sender.tag {
        case 1:
            value = vendingMachine.buy(foodName: "페퍼로니피자", restaurant: "피자헛")
        case 2:
            value = vendingMachine.buy(foodName: "불고기버거", restaurant: "맥도날드")
        case 3:
            value = vendingMachine.buy(foodName: "엽기떡볶이", restaurant: "엽기떡볶이")
        case 4:
            value = vendingMachine.buy(foodName: "보쌈", restaurant: "원할머니보쌈")
        case 5:
            value = vendingMachine.buy(foodName: "양념치킨", restaurant: "교촌치킨")
        default:
            break
        }
        
        checkAbleFood(foodList: (value?.foodList)!)
        view.balanceLabel.text = String("잔액: \(value?.balance ?? 0)원")
    }
    
    func setInstance(vendingMachine: VendingMachine) {
        self.vendingMachine = vendingMachine
    }

    func addStock() {
        vendingMachine.addProduct(food: Pizza(restaurant: "피자헛", capacity: 10, price: 20000, foodName: "페퍼로니피자", extraCheese: false))
        vendingMachine.addProduct(food: Hamberger(restaurant: "맥도날드", capacity: 10, price: 4000, foodName: "불고기버거", upgradeSize: true, withFrenchFry: true))
        vendingMachine.addProduct(food: KoreanFood(restaurant: "엽기떡볶이", capacity: 10, price: 15000, foodName: "엽기떡볶이", spicyDegree: 30))
        vendingMachine.addProduct(food: KoreanFood(restaurant: "원할머니보쌈", capacity: 10, price: 25000, foodName: "보쌈", spicyDegree: 0))
        vendingMachine.addProduct(food: Chicken(restaurant: "교촌치킨", capacity: 10, price: 18000, foodName: "양념치킨", spicy: true, withBeer: true))
    }
}

