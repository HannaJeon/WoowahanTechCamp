//
//  Pizza.swift
//  Food
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class Pizza: Food {
    private let extraCheese: Bool
    
    init(restaurant: String, capacity: Int, price: Int, foodName: String, extraCheese: Bool) {
        self.extraCheese = extraCheese
        
        var totalPrice = price
        if self.extraCheese {
            totalPrice += 500
        }
        super.init(restaurant: restaurant, capacity: capacity, price: totalPrice, foodName: foodName, kindOfProduct: "Pizza")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.extraCheese = aDecoder.decodeBool(forKey: "extraCheese")
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(extraCheese, forKey: "extraCheese")
        super.encode(with: aCoder)
    }
}
