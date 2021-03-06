//
//  Networking.swift
//  GoogleImages
//
//  Created by woowabrothers on 2017. 7. 24..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class Networking {
    func getJsonData(url: String) {
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with: URL(string: url)!) { (data, response, error) in
            if let jsonData = data {
                do {
                    let contents = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [[String:Any]]
                        NotificationCenter.default.post(name: NSNotification.Name("getJsonData"), object: self, userInfo: ["jsonData" : contents])
                } catch {
                    print("catch")
                }
            }
        }.resume()
    }
    
    func getImageData(url: String, callback: @escaping (_ imageData: Data) -> Void) {
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: url)!)
            if let imageData = data {
                callback(imageData)
            }
        }
    }
    
}
