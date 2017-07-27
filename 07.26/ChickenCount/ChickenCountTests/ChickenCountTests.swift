//
//  ChickenCountTests.swift
//  ChickenCountTests
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import XCTest
@testable import ChickenCount

class ChickenCountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNetworking() {
        let networking = Networking()
        networking.postConfirm(message: ["username" : "01029000019", "text" : "012345"])
        

        let expectation = XCTNSNotificationExpectation(name: "testPostConfirm", object: networking)
        XCTWaiter().wait(for: [expectation], timeout: 5)
    }
    
    func testKeyChain() {
        let keyChain = KeyChain()
        User.sharedInstance.set(id: "testID", password: "testPASSWORD")
        User.sharedInstance.set(chickenDate: Date())
        User.sharedInstance.set(phoneNumber: "testPhoneNumber")
        keyChain.saveKeyChain(userInfo: User.sharedInstance)
        keyChain.loadKeyChain()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
