//
//  KeyChain.swift
//  ChickenCount
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class KeyChain {
    private let keychaineWrapper = KeychainWrapper(serviceName: KeychainWrapper.standard.serviceName)
    
    func saveKeyChain(userInfo: User) {
        if keychaineWrapper.set(userInfo, forKey: "userKeyChain") {
            print("success")
        } else {
            print("fail")
        }
    }
    
    func loadKeyChain() {
        if let object = keychaineWrapper.object(forKey: "userKeyChain") as? User {
            User.sharedInstance = object
        }
    }
}
