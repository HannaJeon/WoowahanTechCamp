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
    
    convenience init(detailInfo: [String:Any], hash: String) {
        let hash = hash
        let productDescription = detailInfo["product_description"] as! String
        let topImage = detailInfo["top_image"] as! String
        let thumbImage = detailInfo["thumb_images"] as! [String]
        let detailSection = detailInfo["detail_section"] as! [String]
        let deliveryInfo = detailInfo["delivery_info"] as! String
        let deliveryFee = detailInfo["delivery_fee"] as! String
        let prices = detailInfo["prices"] as! [String]
        let point = detailInfo["point"] as! String
        self.init(hash: hash, productDescription: productDescription, topImage: topImage, thumbImage: thumbImage, detailSection: detailSection, deliveryInfo: deliveryInfo, deliveryFee: deliveryFee, prices: prices, point: point)
    }
    
}
