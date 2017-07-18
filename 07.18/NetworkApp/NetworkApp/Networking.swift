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

    func getJsonData() {
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with: URL(string: "http://52.78.212.27:8080/woowa/main")!) { (data, response, error) in
            if let jsonData = data {
                do {
                    let contents = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [[String:Any]]
                    NotificationCenter.default.post(name: NSNotification.Name("jsonData"), object: self, userInfo: ["jsonArray" : contents])
                    for content in contents {
                        self.downloadImage(url: content["image"] as! String)
                    }
//                    print(contents)
                } catch {
                    print("catch")
                }
            }
        }.resume()
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
    
//    func reachability() {
//        let network = Alamofire.NetworkReachabilityManager()
//        network?.startListening()
//        network?.listener = { status in
//            if status == .notReachable {
//                print(status, 1)
//                NotificationCenter.default.post(name: NSNotification.Name("changeReachability"), object: self, userInfo: ["reachability":false])
//            } else if status == .reachable(.ethernetOrWiFi) {
//                print(status, 2)
//                NotificationCenter.default.post(name: NSNotification.Name("changeReachability"), object: self, userInfo: ["reachability":true])
//            }
//        }
//    }
    
}
