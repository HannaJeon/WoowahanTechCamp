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
}
