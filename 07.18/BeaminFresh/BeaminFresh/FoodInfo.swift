//
//  FoodInfo.swift
//  BeaminFresh
//
//  Created by HannaJeon on 2017. 7. 18..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import Foundation

enum Type: Int {
    case main = 0, course, side, soup
    
    func returnDescription() -> (title: String, description: String) {
        switch self {
        case .main:
            return (title: "메인반찬", description: "담기만 하면 완성되는 메인반찬")
        case .course:
            return (title: "반찬세트", description: "고민없이 한 번에 반찬세트")
        case .side:
            return (title: "밑반찬", description: "언제 먹어도 든든한 밑반찬")
        case .soup:
            return (title: "국・찌개", description: "김이 모락모락 국・찌개")
        }
    }
    
    
}

class FoodInfo {
    internal private(set) var detailHash: String
    internal private(set) var image: String
    internal private(set) var alt: String
    internal private(set) var deliveryType: [String]
    internal private(set) var title: String
    internal private(set) var description: String
    internal private(set) var type: Type
    internal private(set) var normalPrice: String?
    internal private(set) var salePrice: String?
    internal private(set) var badge: [String]?
    
    init(detailHash: String, image: String, alt: String, deliveryType: [String], title: String, description: String, type: Type, normalPrice: String?, salePrice: String?, badge: [String]?) {
        self.detailHash = detailHash
        self.image = image
        self.alt = alt
        self.deliveryType = deliveryType
        self.title = title
        self.description = description
        self.type = type
        self.normalPrice = normalPrice
        self.salePrice = salePrice
        self.badge = badge
    }
    
    convenience init(foodInfo: [String:Any], type: Type) {
        let detailHash = foodInfo["detail_hash"] as! String
        let image = foodInfo["image"] as! String
        let alt = foodInfo["alt"] as! String
        let deliveryType = foodInfo["delivery_type"] as! [String]
        let title = foodInfo["title"] as! String
        let description = foodInfo["description"] as! String
        let normalPrice = foodInfo["n_price"] as? String
        let salePrice = foodInfo["s_price"] as? String
        let badge = foodInfo["badge"] as? [String]
        self.init(detailHash: detailHash, image: image, alt: alt, deliveryType: deliveryType, title: title, description: description, type: type, normalPrice: normalPrice, salePrice: salePrice, badge: badge)
    }
}
