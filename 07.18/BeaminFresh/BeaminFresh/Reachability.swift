//
//  Reachability.swift
//  NetworkApp
//
//  Created by HannaJeon on 2017. 7. 18..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import Foundation
import Alamofire

class Reachability {
    static let sharedInstance = Reachability()
    let reachability = NetworkReachabilityManager()!
    
    func startMonitoring() {
        reachability.listener = { status in
            let currentStatus: Bool
            
            switch status {
            case .notReachable, .unknown:
                currentStatus = false
            case .reachable(.ethernetOrWiFi), .reachable(.wwan):
                currentStatus = true
            }
            NotificationCenter.default.post(name: NSNotification.Name("ReachabilityChanged"), object: self, userInfo: ["status" : currentStatus])
        }
        reachability.startListening()
    }
}
