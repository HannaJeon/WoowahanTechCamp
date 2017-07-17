//
//  VendingMachine.swift
//  Food
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class VendingMachine: NSObject, NSCoding {
    required init?(coder aDecoder: NSCoder) {
        products = aDecoder.decodeObject(forKey: "products") as! [Food]
        balance = aDecoder.decodeInteger(forKey: "balance")
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(products, forKey: "products")
        aCoder.encode(balance, forKey: "balance")
    }
    
    override init() {}

    private var products = [Food]()
    private var buyList = [String]()
    private var balance = Int()
    
    func getBalance() -> Int {
        return balance
    }
    
    func setBalance(balance: Int) {
        self.balance += balance
    }
    
//    - 특정 음식을 추가하는 함수
    func addProduct(food: Food) {
        for _ in 0..<food.getCapacity() {
            products.append(food)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeModel"), object: ViewController(), userInfo: ["stock" : checkStock(), "ableFoodList":checkAblePurchase(currentBalance: balance)])
    }
    
//    - 전체 음식 재고를 (사전으로 표현하는) 종류별로 리턴하는 함수
    func checkStock() -> [Food:Int] {
        var stockDic = [Food:Int]()
        
        for product in products {
            if let stock = stockDic[product] {
                stockDic[product] = stock + 1
            } else {
                stockDic[product] = 1
            }
        }
        
        return stockDic
    }

//    - 금액을 입력하면 구매가능한 음식 목록을 리턴하는 함수
    func checkAblePurchase(currentBalance: Int) -> [Food] {
        var foodList = [Food]()
        let menuList = Set(products)

        for menu in menuList {
            if currentBalance >= menu.getPrice() {
                foodList.append(menu)
            }
        }
        return foodList
    }

//    - 특정 음식를 구매하면 잔액을 리턴하는 함수
    func buy(kindOfProduct: String) -> Int {
        for product in products {
            if product.getKindOfProduct() == kindOfProduct {
                if let index = products.index(of: product) {
                    buyList.append(kindOfProduct)
                    products.remove(at: index)
                    balance -= product.getPrice()
                    break
                }
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeModel"), object: ViewController(), userInfo: ["stock" : checkStock(), "ableFoodList":checkAblePurchase(currentBalance: balance), "buyList":checkBuyList()])
        return balance
    }
    
//    - 실행 이후 구매한 음식 이름과 금액을 사전으로 추상화하고 전체 구매 목록을 배 열로 리턴하는 함수
    func checkBuyList() -> [String] {
        return buyList
    }
    
    func reset() {
        products = [Food]()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeModel"), object: ViewController(), userInfo: ["stock" : checkStock(), "ableFoodList":checkAblePurchase(currentBalance: balance)])
    }
}
