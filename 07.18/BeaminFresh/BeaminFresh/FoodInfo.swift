//
//  FoodInfo.swift
//  BeaminFresh
//
//  Created by HannaJeon on 2017. 7. 18..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import Foundation

class FoodInfo {
    internal private(set) var detailHash: String
    internal private(set) var image: String
    internal private(set) var alt: String
    internal private(set) var deliveryType: [String]
    internal private(set) var title: String
    internal private(set) var description: String
    internal private(set) var normalPrice: String?
    internal private(set) var salePrice: String?
    internal private(set) var badge: [String]?
    
    init(detailHash: String, image: String, alt: String, deliveryType: [String], title: String, description: String, normalPrice: String?, salePrice: String?, badge: [String]?) {
        self.detailHash = detailHash
        self.image = image
        self.alt = alt
        self.deliveryType = deliveryType
        self.title = title
        self.description = description
        self.normalPrice = normalPrice
        self.salePrice = salePrice
        self.badge = badge
    }
}
