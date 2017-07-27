//
//  User.swift
//  ChickenCount
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    static var sharedInstance = User()
    private(set) var id: String?
    private(set) var password: String?
    private(set) var chickenDate: Date?
    private(set) var phoneNumber: String?
    
    override init() {}
    
    required init?(coder aDecoder: NSCoder) {
        if let id = aDecoder.decodeObject(forKey: "id") as? String {
            self.id = id
        }
        if let password = aDecoder.decodeObject(forKey: "password") as? String {
            self.password = password
        }
        if let chickenDate = aDecoder.decodeObject(forKey: "chickenDate") as? Date {
            self.chickenDate = chickenDate
        }
        if let phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? String {
            self.phoneNumber = phoneNumber
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(chickenDate, forKey: "chickenDate")
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
    }
    
    func set(id: String, password: String) {
        self.id = id
        self.password = password
    }
    
    func set(chickenDate: Date) {
        self.chickenDate = chickenDate
    }
    
    func set(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
}
