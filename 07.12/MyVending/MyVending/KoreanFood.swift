//
//  KoreanFood.swift
//  Food
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class KoreanFood: Food {
    override init(restaurant: String, capacity: Int, price: Int, foodName: String, kindOfProduct: String) {
        super.init(restaurant: restaurant, capacity: capacity, price: price, foodName: foodName, kindOfProduct: kindOfProduct)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
    }
}

class Dduck: KoreanFood {
    private let spicyDegree: Int
    
    init(restaurant: String, capacity: Int, price: Int, foodName: String, spicyDegree: Int) {
        self.spicyDegree = spicyDegree
        super.init(restaurant: restaurant, capacity: capacity, price: price, foodName: foodName, kindOfProduct: "Dduck")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.spicyDegree = aDecoder.decodeInteger(forKey: "spicyDegree")
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(spicyDegree, forKey: "spicyDegree")
        super.encode(with: aCoder)
    }
}

class Bossam: KoreanFood {
    private let extraSize: Bool
    
    init(restaurant: String, capacity: Int, price: Int, foodName: String, extraSize: Bool) {
        self.extraSize = extraSize
        
        var totalPrice = price
        if self.extraSize {
            totalPrice += 1000
        }
        
        super.init(restaurant: restaurant, capacity: capacity, price: totalPrice, foodName: foodName, kindOfProduct: "Bossam")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.extraSize = aDecoder.decodeBool(forKey: "extraSizeBossam")
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(extraSize, forKey: "extraSizeBossam")
        super.encode(with: aCoder)
    }
    
}
