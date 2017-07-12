//
//  Food.swift
//  Food
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class Food: Hashable, Equatable {
    var hashValue: Int { get { return foodName.hashValue } }
    
    static func ==(lhs: Food, rhs: Food) -> Bool {
        return lhs.foodName == rhs.foodName
    }

    private let restaurant: String
    private let capacity: Int
    private let price: Int
    private let foodName: String
    private let produceDate: Date
    private let kindOfProduct: String
    
    init(restaurant: String, capacity: Int, price: Int, foodName: String, kindOfProduct: String) {
        self.restaurant = restaurant
        self.capacity = capacity
        self.price = price
        self.foodName = foodName
        self.produceDate = Date()
        self.kindOfProduct = kindOfProduct
    }
    
    func getFoodName() -> String {
        return foodName
    }
    
    func getPrice() -> Int {
        return price
    }
    
    func getRestaurant() -> String {
        return restaurant
    }
    
    func getCapacity() -> Int {
        return capacity
    }

}
