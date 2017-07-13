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
    let pizza1 = Pizza(restaurant: "피자헛", capacity: 50, price: 20000, foodName: "콤비네이션피자", extraCheese: true)
    let pizza2 = Pizza(restaurant: "피자헛", capacity: 30, price: 20000, foodName: "페퍼로니피자", extraCheese: false)
    let pizza3 = Pizza(restaurant: "미스터피자", capacity: 80, price: 20000, foodName: "콤비네이션피자", extraCheese: false)
    let pizza4 = Pizza(restaurant: "미스터피자", capacity: 40, price: 20000, foodName: "페퍼로니피자", extraCheese: true)
    
    let myView = MyView()
    var buttonTag = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(myView)
        print(vendingMachine.checkStock())
        print(myView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setLabel), name: NSNotification.Name(rawValue: "addProduct"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func setLabel(_ notification: Notification) {
        let view = self.view as! MyView
//        switch buttonTag {
//        case 1:
//            <#code#>
//        case 2:
//            
//        case 3:
//            
//        case 4:
//            
//        case 5:
//            
//        default:
//            break
//        }
        
        let stock = notification.userInfo as! [String:[String:Int]]
        print(12345)
        print(view.foodNameLabels[buttonTag])
        for brand in stock {
            
//            switch view.foodNameLabels {
//            case <#pattern#>:
//                <#code#>
//            default:
//                <#code#>
//            }
//            if String(describing: brand.key) == view.foodNameLabels[buttonTag].text! {
//                let val = brand.value[view.foodNameLabels[buttonTag].text!]
//                print(val)
//                view.stockLabels[buttonTag].text = String(describing: val!)
//                capacityLabels[buttonTag].text = String(describing: val!)
//            }
        }
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

