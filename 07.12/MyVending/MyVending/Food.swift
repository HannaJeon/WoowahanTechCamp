//
//  Food.swift
//  Food
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class Food: NSObject, NSCoding {
    required init?(coder aDecoder: NSCoder) {
        restaurant = aDecoder.decodeObject(forKey: "restaurant") as! String
        capacity = aDecoder.decodeInteger(forKey: "capacity")
        price = aDecoder.decodeInteger(forKey: "price")
        foodName = aDecoder.decodeObject(forKey: "foodName") as! String
        produceDate = aDecoder.decodeObject(forKey: "produceDate") as! Date
        kindOfProduct = aDecoder.decodeObject(forKey: "kindOfProduct") as! String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(restaurant, forKey: "restaurant")
        aCoder.encode(capacity, forKey: "capacity")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(foodName, forKey: "foodName")
        aCoder.encode(produceDate, forKey: "produceDate")
        aCoder.encode(kindOfProduct, forKey: "kindOfProduct")
    }

    override var hashValue: Int { return kindOfProduct.hashValue }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Food {
            return object.kindOfProduct == self.kindOfProduct
        } else {
            return false
        }
    }
    
//    static func ==(lhs: Food, rhs: Food) -> Bool {
//        return lhs.kindOfProduct == rhs.kindOfProduct
//    }

    private let restaurant: String
    private var capacity: Int
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
    
    func getKindOfProduct() -> String {
        return kindOfProduct
    }
    
    func setCapacity(capacity: Int) {
        self.capacity += capacity
    }

}
