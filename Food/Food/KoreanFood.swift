//
//  KoreanFood.swift
//  Food
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class KoreanFood: Food {
    private let spicyDegree: Int
    
    init(restaurant: String, capacity: Int, price: Int, foodName: String, produceDate: Date, spicyDegree: Int) {
        self.spicyDegree = spicyDegree
        super.init(restaurant: restaurant, capacity: capacity, price: price, foodName: foodName, kindOfProduct: "KoreanFood")
    }
}
