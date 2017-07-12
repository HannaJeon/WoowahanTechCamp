//
//  main.swift
//  Food
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

let chicken = Chicken(restaurant: "교촌치킨", capacity: 5, price: 20000, foodName: "양념치킨", spicy: true, withBeer: true)
let pizza = Pizza(restaurant: "피자헛", capacity: 3, price: 30000, foodName: "콤비네이션", extraCheese: true)
let pizza3 = Pizza(restaurant: "미스터피자", capacity: 2, price: 30000, foodName: "콤비네이션", extraCheese: false)
let pizza4 = Pizza(restaurant: "피자헛", capacity: 10, price: 15000, foodName: "페퍼로니피자", extraCheese: true)
//dump(chicken)
//dump(pizza)
//dump(pizza1)

let vendingMachine = VendingMachine()
vendingMachine.addProduct(food: chicken)
vendingMachine.addProduct(food: pizza)
vendingMachine.addProduct(food: pizza3)
vendingMachine.addProduct(food: pizza4)
//dump(vendingMachine.products)
//print(vendingMachine.products)
//print(vendingMachine.checkStock())
print(vendingMachine.checkAblePurchase(money: 16000))
