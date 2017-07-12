//
//  Chicken.swift
//  Food
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class Chicken: Food {
    private let spicy: Bool
    private let withBeer: Bool
    
    init(restaurant: String, capacity: Int, price: Int, foodName: String, spicy: Bool, withBeer: Bool) {
        self.spicy = spicy
        self.withBeer = withBeer
        
        var totalPrice = price
        if self.spicy {
            totalPrice += 1000
        }
        if self.withBeer {
            totalPrice += 2000
        }
        
        super.init(restaurant: restaurant, capacity: capacity, price: totalPrice, foodName: foodName, kindOfProduct: "Chicken")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.spicy = aDecoder.decodeBool(forKey: "spicy")
        self.withBeer = aDecoder.decodeBool(forKey: "withBeer")
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(spicy, forKey: "spicy")
        aCoder.encode(withBeer, forKey: "withBeer")
        super.encode(with: aCoder)
    }
}
