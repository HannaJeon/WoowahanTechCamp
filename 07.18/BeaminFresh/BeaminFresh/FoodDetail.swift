//
//  FoodDetail.swift
//  BeaminFresh
//
//  Created by HannaJeon on 2017. 7. 19..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import Foundation

class FoodDetail {
    internal private(set) var hash: String = String()
    internal private(set) var productDescription: String = String()
    internal private(set) var topImage: String = String()
    internal private(set) var thumbImage: [String] = [String]()
    internal private(set) var detailSection: [String] = [String]()
    internal private(set) var deliveryInfo: String = String()
    internal private(set) var deliveryFee: String = String()
    internal private(set) var prices: [String] = [String]()
    internal private(set) var point: String = String()
    
    init() {}
    
    init(hash: String, productDescription: String, topImage: String, thumbImage: [String], detailSection: [String], deliveryInfo: String, deliveryFee: String, prices: [String], point: String) {
        self.hash = hash
        self.productDescription = productDescription
        self.topImage = topImage
        self.thumbImage = thumbImage
        self.detailSection = detailSection
        self.deliveryInfo = deliveryInfo
        self.deliveryFee = deliveryFee
        self.prices = prices
        self.point = point
    }
    
}
