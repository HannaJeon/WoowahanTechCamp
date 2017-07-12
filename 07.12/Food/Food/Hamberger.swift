//
//  Hamberger.swift
//  Food
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class Hamberger: Food {
    private let upgradeSize: Bool
    private let withFrenchFry: Bool
    
    init(restaurant: String, capacity: Int, price: Int, foodName: String, kindOfProduct: String, upgradeSize: Bool, withFrenchFry: Bool) {
        self.upgradeSize = upgradeSize
        self.withFrenchFry = withFrenchFry
        
        var totalPrice = price
        if self.upgradeSize {
            totalPrice += 500
        }
        if self.withFrenchFry {
            totalPrice += 2000
        }
        
        super.init(restaurant: restaurant, capacity: capacity, price: price, foodName: foodName, kindOfProduct: "Hamberger")
    }
}
