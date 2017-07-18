//
//  SerializationJson.swift
//  BeaminFresh
//
//  Created by HannaJeon on 2017. 7. 18..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import Foundation

class SerializationJson {
    
    func serializationJson() -> [[String:Any]]? {
        let url = Bundle.main.url(forResource: "main", withExtension: "json")
        guard (url != nil) else { return nil }
        
        do {
            let jsonData = try Data(contentsOf: url!)
            let contents = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [[String:Any]]
            return contents
//            makeModel(contents: contents)
        } catch {
            return nil
        }
    }
    
    func makeModel() -> [FoodInfo] {
        var foodsInfo = [FoodInfo]()
        guard let contents = serializationJson() else { return foodsInfo }
        
        for content in contents {
            let info = FoodInfo(detailHash: content["detail_hash"] as! String, image: content["image"] as! String, alt: content["alt"] as! String, deliveryType: content["delivery_type"] as! [String], title: content["title"] as! String, description: content["description"] as! String, normalPrice: content["n_price"] as? String ?? nil, salePrice: content["s_price"] as? String ?? nil, badge: content["badge"] as? [String] ?? nil)
            foodsInfo.append(info)
        }
        return foodsInfo
    }
    
}
