//
//  NetworkJson.swift
//  NetworkApp
//
//  Created by HannaJeon on 2017. 7. 18..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import Foundation
import Alamofire

class Networking {
    
    func getURL() -> String {
        let filePath = Bundle.main.path(forResource: "Info", ofType: "plist")
        let info = NSDictionary(contentsOfFile: filePath!)
        let url = info?["URL"] as! String
        
        return url
    }

    func getJsonData(filePath: [String]) {
        for filepath in filePath {
            Alamofire.request(getURL()+filepath).responseJSON(completionHandler: { (response) in
                var foodList = [FoodInfo]()
                
                if let contents = response.result.value as? [[String:Any]] {
                    let type = filepath == "main" ? Type.main : filepath == "course" ? .course : filepath == "side" ? .side : .soup
                 
                    contents.forEach({ (content) in
                        let info = FoodInfo(detailHash: content["detail_hash"] as! String, image: content["image"] as! String, alt: content["alt"] as! String, deliveryType: content["delivery_type"] as! [String], title: content["title"] as! String, description: content["description"] as! String, type: type, normalPrice: content["n_price"] as? String ?? nil, salePrice: content["s_price"] as? String ?? nil, badge: content["badge"] as? [String] ?? nil)
                        foodList.append(info)
                    })
                }
                NotificationCenter.default.post(name: NSNotification.Name("changedFoodInfo"), object: self, userInfo: ["foodInfo" : foodList])
            })
        }
    }
    
    func postMessage(message: [String:String]) {
        if let jsonData = try? JSONSerialization.data(withJSONObject: message, options: []) {
            var request = URLRequest(url: URL(string: "https://hooks.slack.com/services/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")!)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            
            URLSession(configuration: .default).dataTask(with: request, completionHandler: { (data, response, error) in
                if let err = error {
                    print(err)
                }
            }).resume()
        }
    }
    
    func downloadImage(url: String) {
        
        
//        KingfisherManager.shared.cache.cachePath(forKey: "url")
//        Alamofire.request(url).responseData { (response) in
//            print(response)
//            let fileurl = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//            print(fileurl)
//            let image = UIImage(contentsOfFile: String(describing: fileurl))
//            print(image)
//        }
    }
    
}
