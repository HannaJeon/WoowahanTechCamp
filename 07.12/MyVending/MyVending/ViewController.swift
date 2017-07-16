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
        checkStockInit()
        foodImageInit()
        foodNameLabelsInit()
        addButtonsInit()
        buyButtonsInit()
        anotherSettingInit()
        stockLabelsInit()
        resetButtonInit()
        self.view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNoti), name: NSNotification.Name(rawValue: "addProduct"), object: nil)
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
        balanceLabel.text = "잔액: 0원"
    }
}

extension ViewController {
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
    }
    
    func receiveNoti(_ notification: Notification) {
        if let stock = notification.userInfo as? [String:Int] {
            sendDataToLabel(stock: stock)
        }
    }
    
    func sendDataToLabel(stock: [String:Int]) {
        stockLabels.forEach { (label) in
            switch label.tag {
            case 1:
                guard let value = stock["피자헛"] else { return }
                label.text = "\(value)개"
            case 2:
                guard let value = stock["맥도날드"] else { return }
                label.text = "\(value)개"
            case 3:
                guard let value = stock["엽기떡볶이"] else { return }
                label.text = "\(value)개"
            case 4:
                guard let value = stock["원할머니보쌈"] else { return }
                label.text = "\(value)개"
            case 5:
                guard let value = stock["교촌치킨"] else { return }
                label.text = "\(value)개"
            default:
                break
            }
        }
    }
    
    func insert(_ sender: UIButton) {
        var value: (foodList: [String:[String]], balance: Int)
        
        if sender.tag == 1 {
            value = vendingMachine.checkAblePurchase(money: 1000)
        } else {
            value = vendingMachine.checkAblePurchase(money: 5000)
        }
        
        checkAbleFood(foodList: value.foodList)
        balanceLabel.text = String("잔액: \(value.balance)원")
    }
    
    func checkAbleFood(foodList: [String:[String]]) {
        buyButtons.forEach { (button) in
            button.setTitleColor(UIColor.gray, for: .normal)
            button.isEnabled = false
        }
        
        if !foodList.isEmpty {
            foodList.forEach({ (food: (key: String, value: [String])) in
                switch food.key {
                case "피자헛":
                    buyButtons[0].setTitleColor(UIColor.red, for: .normal)
                    buyButtons[0].isEnabled = true
                case "맥도날드":
                    buyButtons[1].setTitleColor(UIColor.red, for: .normal)
                    buyButtons[1].isEnabled = true
                case "엽기떡볶이":
                    buyButtons[2].setTitleColor(UIColor.red, for: .normal)
                    buyButtons[2].isEnabled = true
                case "원할머니보쌈":
                    buyButtons[3].setTitleColor(UIColor.red, for: .normal)
                    buyButtons[3].isEnabled = true
                case "교촌치킨":
                    buyButtons[4].setTitleColor(UIColor.red, for: .normal)
                    buyButtons[4].isEnabled = true
                default:
                    break
                }
            })
        }
    }
    
    func buyFood(_ sender: UIButton) {
        var value: (stock: [String:Int], foodList: [String:[String]], balance: Int)? = nil
        
        switch sender.tag {
        case 1:
            value = vendingMachine.buy(foodName: "페퍼로니피자", restaurant: "피자헛")
            cardImage = UIImageView(image: #imageLiteral(resourceName: "pizza"))
        case 2:
            value = vendingMachine.buy(foodName: "불고기버거", restaurant: "맥도날드")
            cardImage = UIImageView(image: #imageLiteral(resourceName: "hamburger"))
        case 3:
            value = vendingMachine.buy(foodName: "엽기떡볶이", restaurant: "엽기떡볶이")
            cardImage = UIImageView(image: #imageLiteral(resourceName: "dduck"))
        case 4:
            value = vendingMachine.buy(foodName: "보쌈", restaurant: "원할머니보쌈")
            cardImage = UIImageView(image: #imageLiteral(resourceName: "bossam"))
        case 5:
            value = vendingMachine.buy(foodName: "양념치킨", restaurant: "교촌치킨")
            cardImage = UIImageView(image: #imageLiteral(resourceName: "chicken"))
        default:
            break
        }
        
        cardImage.frame = CGRect(x: x, y: 575, width: 140, height: 100)
        x += 50
        view.addSubview(cardImage)
        
        sendDataToLabel(stock: value!.stock)
        checkAbleFood(foodList: value!.foodList)
        balanceLabel.text = String("잔액: \(value?.balance ?? 0)원")
    }
    
    func reset() {
        vendingMachine.reset()
        addStock(capacity: 1)
    }
    
    func setInstance(vendingMachine: VendingMachine) {
        self.vendingMachine = vendingMachine
    }
    
    func addStock(capacity: Int) {
        vendingMachine.addProduct(food: Pizza(restaurant: "피자헛", capacity: capacity, price: 20000, foodName: "페퍼로니피자", extraCheese: false))
        vendingMachine.addProduct(food: Hamberger(restaurant: "맥도날드", capacity: capacity, price: 4000, foodName: "불고기버거", upgradeSize: true, withFrenchFry: true))
        vendingMachine.addProduct(food: KoreanFood(restaurant: "엽기떡볶이", capacity: capacity, price: 15000, foodName: "엽기떡볶이", spicyDegree: 30))
        vendingMachine.addProduct(food: KoreanFood(restaurant: "원할머니보쌈", capacity: capacity, price: 25000, foodName: "보쌈", spicyDegree: 0))
        vendingMachine.addProduct(food: Chicken(restaurant: "교촌치킨", capacity: capacity, price: 18000, foodName: "양념치킨", spicy: true, withBeer: true))
    }
    
}

