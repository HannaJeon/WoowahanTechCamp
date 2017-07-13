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
        products = aDecoder.decodeObject(forKey: "products") as! [String : [Food]]
        stockDic = aDecoder.decodeObject(forKey: "stockDic") as! [String : [String : Int]]
        balance = aDecoder.decodeInteger(forKey: "balance")
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(products, forKey: "products")
        aCoder.encode(stockDic, forKey: "stockDic")
        aCoder.encode(balance, forKey: "balance")
    }
    
    override init() {}

    private var products = [String:[Food]]()
    private var stockDic = [String:[String:Int]]()
    private var purchaseList = [String:[String]]()
    private var balance = Int()
    
//    - 특정 음식을 추가하는 함수
    func addProduct(food: Food) {
        for _ in 0..<food.getCapacity() {
            if let product = products[food.getRestaurant()] {
                products[food.getRestaurant()] = product + [food]
            } else {
                products[food.getRestaurant()] = [food]
            }
        }
        
        guard let list = products[food.getRestaurant()] else { return }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addProduct"), object: ViewController(), userInfo: [food.getRestaurant():list.count])
    }
    
//    - 전체 음식 재고를 (사전으로 표현하는) 종류별로 리턴하는 함수
    func checkStock() -> [String:[String:Int]] {
        for product in products {
            var stock = [String:Int]()
            for food in product.value {
                if let value = stock[food.getFoodName()] {
                    stock[food.getFoodName()] = value + 1
                } else {
                    stock[food.getFoodName()] = 1
                }
            }
            if let arr = product.value.first {
                stockDic[arr.getRestaurant()] = stock
            }
        }
        return stockDic
    }
    
//    - 금액을 입력하면 구매가능한 음식 목록을 리턴하는 함수
    func checkAblePurchase(money: Int) -> (foodList: [String:[String]], balance: Int) {
        balance += money
        var result = [String:[String]]()
        
        for product in products {
            let menuList = Set(product.value.map{ $0 })
            for menu in menuList {
                if money >= menu.getPrice() {
                    if let brand = result[menu.getRestaurant()] {
                        result[menu.getRestaurant()] = brand + [menu.getFoodName()]
                    } else {
                        result[menu.getRestaurant()] = [menu.getFoodName()]
                    }
                }
            }
        }
        print(result, balance)
        return (result, balance)
    }
    
//    - 특정 음식를 구매하면 잔액을 리턴하는 함수
    func buy(foodName: String, restaurant: String) -> Int {
        guard var product = products[restaurant] else { return balance }

        for food in product {
            if food.getFoodName() == foodName {
                if let index = product.index(of: food) {
                    if let list = purchaseList[food.getRestaurant()] {
                        purchaseList[food.getRestaurant()] = list + [food.getFoodName()]
                    } else {
                        purchaseList[food.getRestaurant()] = [food.getFoodName()]
                    }
                    product.remove(at: index)
                    balance -= food.getPrice()
                    break
                }
            }
        }
        return balance
    }
//    - 실행 이후 구매한 음식 이름과 금액을 사전으로 추상화하고 전체 구매 목록을 배 열로 리턴하는 함수
    // [브랜드:[메뉴:총금액]]
    func checkPurchaseList() -> [String:[String]] {
        return purchaseList
    }
}
