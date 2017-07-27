//
//  Networking.swift
//  ChickenCount
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class Networking {
    func postConfirm(message: [String:String]) {
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(30000)) {
            NotificationCenter.default.post(name: NSNotification.Name("startCountTime"), object: self)
        }
    }
    
    
}
