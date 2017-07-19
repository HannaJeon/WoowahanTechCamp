//
//  NetworkJson.swift
//  NetworkApp
//
//  Created by HannaJeon on 2017. 7. 18..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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
                        
//                        self.downloadImage(url: content["image"] as! String, hash: content["detail_hash"] as! String)
                        foodList.append(info)
                    })
                }
                NotificationCenter.default.post(name: NSNotification.Name("changedFoodInfo"), object: self, userInfo: ["foodInfo" : foodList])
            })
        }
    }
    
    func getFoodDetail(hash: String) {
        Alamofire.request("\(getURL())/detail/\(hash)").responseJSON { (response) in
            guard let jsonData = response.data else { return }
            
            let contents = JSON(data: jsonData).dictionaryValue
            if let data = contents["data"]?.dictionaryValue,
            let hash = contents["hash"]?.stringValue,
            let productDescription = data["product_description"]?.stringValue,
            let topImage = data["top_image"]?.stringValue,
            let thumbImage = data["thumb_images"]?.arrayValue.map({ $0.stringValue }),
            let detailSection = data["detail_section"]?.arrayValue.map({ $0.stringValue }),
            let deliveryInfo = data["delivery_info"]?.stringValue,
            let deliveryFee = data["delivery_fee"]?.stringValue,
            let prices = data["prices"]?.arrayValue.map({ $0.stringValue }),
                let point = data["point"]?.stringValue {
                
                let foodDetail = FoodDetail(hash: hash, productDescription: productDescription, topImage: topImage, thumbImage: thumbImage, detailSection: detailSection, deliveryInfo: deliveryInfo, deliveryFee: deliveryFee, prices: prices, point: point)
                NotificationCenter.default.post(name: NSNotification.Name("getFoodDetail"), object: self, userInfo: ["foodDetail" : foodDetail])
            }
        }
    }
    
    // 이전 Networking 코드
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
    
    //  뻘짓 코드..
//    func downloadImage(url: String, hash: String) {
//        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
//            let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
//            print(path)
//            let fileURL = path.appendingPathComponent("\(hash).png")
//            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
//        }
//        
//        Alamofire.download(url, to: destination).response { response in
//            if let error = response.error {
//                print(error)
//            }
//        }
//    }

//    func getCacheImage(filename: String) -> UIImage? {
//        let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
//        let image = UIImage(contentsOfFile: url.path)
//
//        return image ?? nil
//    }
    
}
