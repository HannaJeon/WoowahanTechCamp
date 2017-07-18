//
//  Reachability.swift
//  NetworkApp
//
//  Created by HannaJeon on 2017. 7. 18..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import Foundation
//import ReachabilitySwift
import Alamofire
//
//class ReachabilityManager {
//    static let sharedInstance = ReachabilityManager()
//    
////    var isNetworkAvailable: Bool {
////        return reachabilityStatus != .notReachable
////    }
//    
////    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
//    let reachability = Reachability()!
//    
//    @objc func reachabilityChanged(_ notification: Notification) {
//        let reachability = notification.object as! Reachability
//        
////        switch reachability.currentReachabilityStatus {
////        case .notReachable:
////        case .reachableViaWiFi, .reachableViaWWAN:
////        }
//        NotificationCenter.default.post(name: NSNotification.Name("reachabilityStatus"), object: self, userInfo: ["status" : reachability.currentReachabilityString])
//    }
//    
//    func startMonitoring() {
////        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: reachability)
//
////        do {
////            try reachability.startNotifier()
////        } catch {
////            print("can not start reachability noti")
////        }
//        switch reachability.currentReachabilityStatus {
//        case .notReachable:
//            print(123)
//        case .reachableViaWiFi, .reachableViaWWAN:
//            print(456)
//        }
//    }
//    
//    func stopMonitoring() {
//        reachability.stopNotifier()
//        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
//    }
//}

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
