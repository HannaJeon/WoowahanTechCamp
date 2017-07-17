//
//  ViewController.swift
//  MyVending
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var addButtons: [UIButton]!
    @IBOutlet var foodImages: [UIImageView]!
    @IBOutlet var buyButtons: [UIButton]!
    @IBOutlet weak var plusCoin1000: UIButton!
    @IBOutlet weak var plusCoin5000: UIButton!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet var stockLabels: [UILabel]!
    @IBOutlet var foodNameLabels: [UILabel]!
    
    var vendingMachine = VendingMachine()
    var cardImage = UIImageView()
    var x = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sendDataToLabel(stock: vendingMachine.checkStock())
        foodImageInit()
        foodNameLabelsInit()
        addButtonsInit()
        buyButtonsInit()
        anotherSettingInit()
        stockLabelsInit()
        resetButtonInit()
        self.view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNoti), name: NSNotification.Name(rawValue: "changeModel"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(receiveNoti), name: NSNotification.Name(rawValue: "addProduct"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(receiveNoti), name: NSNotification.Name(rawValue: "buyProduct"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotiAble), name: NSNotification.Name("ableBuyProduct"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetButtonInit() {
        let viewController = ViewController(nibName: "viewController", bundle: nil)
        let resetButton = UIButton()
        resetButton.frame = CGRect(x: 700, y: 500, width: 100, height: 50)
        resetButton.setTitle("reset", for: .normal)
        resetButton.tintColor = UIColor.red
        resetButton.addTarget(viewController, action: #selector(viewController.reset), for: .touchUpInside)
        self.view.addSubview(resetButton)
    }
    
    func stockLabelsInit() {
        stockLabels.forEach {
            if ($0.text?.isEmpty)! {
                $0.text = "0 개"
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
        addButtons.forEach{ (button) in
            button.setTitle("추가", for: .normal)
            button.addTarget(self, action: #selector(addButtonAction(_:)), for: .touchUpInside)
        }
    }
    
    func buyButtonsInit() {
        buyButtons.forEach { (button) in
            button.setTitle("구매", for: .normal)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.isEnabled = false
            button.addTarget(self, action: #selector(buyFood(_:)), for: .touchUpInside)
        }
    }
    
    func anotherSettingInit() {
        plusCoin1000.addTarget(self, action: #selector(insert(_:)), for: .touchUpInside)
        plusCoin5000.addTarget(self, action: #selector(insert(_:)), for: .touchUpInside)
        plusCoin1000.setTitle("+1000", for: .normal)
        plusCoin5000.setTitle("+5000", for: .normal)
        let value = vendingMachine.checkAblePurchase(money: 0)
        checkAbleFood(foodList: value.foodList)
        balanceLabel.text = "잔액: \(value.balance)원"
    }
}

extension ViewController {
    func addButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            vendingMachine.addProduct(food: Pizza(restaurant: "피자헛", capacity: 10, price: 20000, foodName: "페퍼로니피자", extraCheese: false))
        case 2:
            vendingMachine.addProduct(food: Hamberger(restaurant: "맥도날드", capacity: 10, price: 4000, foodName: "불고기버거", upgradeSize: true, withFrenchFry: true))
        case 3:
            vendingMachine.addProduct(food: Dduck(restaurant: "엽기떡볶이", capacity: 10, price: 15000, foodName: "엽기떡볶이", spicyDegree: 30))
        case 4:
            vendingMachine.addProduct(food: Bossam(restaurant: "원할머니보쌈", capacity: 10, price: 25000, foodName: "보쌈", extraSize: true))
        case 5:
            vendingMachine.addProduct(food: Chicken(restaurant: "교촌치킨", capacity: 10, price: 18000, foodName: "양념치킨", spicy: true, withBeer: true))
        default:
            break
        }
    }
    
    func receiveNoti(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String:Any] {
            print(userInfo)
//            if (userInfo["stock"] != nil) {
//                sendDataToLabel(stock: userInfo["stock"])
//            }
//            if let foodList = userInfo["ableFoodList"] {
//                checkAbleFood(foodList: Array(foodList.flatMap{ $0 }))
//            }
//        }
        }
    }
    
//    func receiveNotiAble(foodList: Notification) {
//        if let foodList = foodList.userInfo as? [String:[String]] {
//            checkAbleFood(foodList: Array(foodList.values).flatMap{ $0 })
//        }
//    }
    
    func sendDataToLabel(stock: [String:Int]) {
        stockLabels.forEach { (label) in
            switch label.tag {
            case 1:
                if let value = stock["Pizza"] {
                    label.text = "\(value) 개"
                } else {
                    label.text = "0 개"
                }
            case 2:
                if let value = stock["Hamberger"] {
                    label.text = "\(value) 개"
                } else {
                    label.text = "0 개"
                }
            case 3:
                if let value = stock["Dduck"] {
                    label.text = "\(value) 개"
                } else {
                    label.text = "0 개"
                }
            case 4:
                if let value = stock["Bossam"] {
                    label.text = "\(value) 개"
                } else {
                    label.text = "0 개"
                }
            case 5:
                if let value = stock["Chicken"] {
                    label.text = "\(value) 개"
                } else {
                    label.text = "0 개"
                }
            default:
                break
            }
        }
    }
    
    func insert(_ sender: UIButton) {
        var value: (foodList: [String], balance: Int)
        
        if sender.tag == 1 {
            value = vendingMachine.checkAblePurchase(money: 1000)
        } else {
            value = vendingMachine.checkAblePurchase(money: 5000)
        }
        
        checkAbleFood(foodList: value.foodList)
        balanceLabel.text = String("잔액: \(value.balance)원")
    }

    func checkAbleFood(foodList: [String]) {
        buyButtons.forEach { (button) in
            button.setTitleColor(UIColor.gray, for: .normal)
            button.isEnabled = false
        }
        
        if !foodList.isEmpty {
            foodList.forEach({ (food) in
                buyButtons.forEach({ (button) in
                    switch (food, button.tag) {
                    case ("Pizza", 1):
                        button.setTitleColor(UIColor.red, for: .normal)
                        button.isEnabled = true
                    case ("Hamberger", 2):
                        button.setTitleColor(UIColor.red, for: .normal)
                        button.isEnabled = true
                    case ("Dduck", 3):
                        button.setTitleColor(UIColor.red, for: .normal)
                        button.isEnabled = true
                    case ("Bossam", 4):
                        button.setTitleColor(UIColor.red, for: .normal)
                        button.isEnabled = true
                    case ("Chicken", 5):
                        button.setTitleColor(UIColor.red, for: .normal)
                        button.isEnabled = true
                    default:
                        break
                    }
                })
            })
        }
    }
    
    func buyFood(_ sender: UIButton) {
        var value = Int()
        
        switch sender.tag {
        case 1:
            value = vendingMachine.buy(kindOfProduct: "Pizza")
            cardImage = UIImageView(image: #imageLiteral(resourceName: "pizza"))
        case 2:
            value = vendingMachine.buy(kindOfProduct: "Hamberger")
            cardImage = UIImageView(image: #imageLiteral(resourceName: "hamburger"))
        case 3:
            value = vendingMachine.buy(kindOfProduct: "Dduck")
            cardImage = UIImageView(image: #imageLiteral(resourceName: "dduck"))
        case 4:
            value = vendingMachine.buy(kindOfProduct: "Bossam")
            cardImage = UIImageView(image: #imageLiteral(resourceName: "bossam"))
        case 5:
            value = vendingMachine.buy(kindOfProduct: "Chicken")
            cardImage = UIImageView(image: #imageLiteral(resourceName: "chicken"))
        default:
            break
        }
        // 구매목록이 변경되었을 때 벤딩머신 노티피케이션
        cardImage.frame = CGRect(x: x, y: 575, width: 140, height: 100)
        x += 50
        view.addSubview(cardImage)
        
        balanceLabel.text = String("잔액: \(value)원")
    }
    
    func reset() {
        vendingMachine.reset()
        addStock(capacity: 1)
    }
    
    func setInstance(vendingMachine: VendingMachine) {
        self.vendingMachine = vendingMachine
    }
    
    func addStock(capacity: Int) {
        // enum으로 반복되는 것들 정리
        vendingMachine.addProduct(food: Pizza(restaurant: "피자헛", capacity: capacity, price: 20000, foodName: "페퍼로니피자", extraCheese: false))
        vendingMachine.addProduct(food: Pizza(restaurant: "미스터피자", capacity: capacity, price: 20000, foodName: "페퍼로니피자", extraCheese: false))
        vendingMachine.addProduct(food: Hamberger(restaurant: "맥도날드", capacity: capacity, price: 4000, foodName: "불고기버거", upgradeSize: true, withFrenchFry: true))
        vendingMachine.addProduct(food: Dduck(restaurant: "엽기떡볶이", capacity: capacity, price: 15000, foodName: "엽기떡볶이", spicyDegree: 30))
        vendingMachine.addProduct(food: Bossam(restaurant: "원할머니보쌈", capacity: capacity, price: 25000, foodName: "보쌈", extraSize: true))
        vendingMachine.addProduct(food: Chicken(restaurant: "교촌치킨", capacity: capacity, price: 18000, foodName: "양념치킨", spicy: true, withBeer: true))
        print(vendingMachine.checkStock())
    }
    
}

