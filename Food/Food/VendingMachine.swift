//
//  VendingMachine.swift
//  Food
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class VendingMachine {
    private var products = [String:[Food]]()
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
    }
    
//    - 전체 음식 재고를 (사전으로 표현하는) 종류별로 리턴하는 함수
    func checkStock() -> [String:[String:Int]] {
        var stockDic = [String:[String:Int]]()
        
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
    func checkAblePurchase(money: Int) -> [String:String] {
        balance += money
        var result = [String:String]()
        
        for product in products {
            let menuList = Set(product.value.map{ $0 })
            for menu in menuList {
                if money >= menu.getPrice() {
                    result[menu.getRestaurant()] = menu.getFoodName()
                }
            }
        }
        return result
    }
    
//    - 특정 음식를 구매하면 잔액을 리턴하는 함수
    func buy(restaurant: String, food: String) {
        if let _ = products[restaurant] {
//            let index = products[restaurant]?.index(of: <#T##Food#>)
//            products[restaurant].remove
        }
    }
//    - 실행 이후 구매한 음식 이름과 금액을 사전으로 추상화하고 전체 구매 목록을 배 열로 리턴하는 함수
}
