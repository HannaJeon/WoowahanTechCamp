//
//  ConfirmViewControllerTest.swift
//  ChickenCount
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import XCTest
import UIKit
@testable import ChickenCount

class ConfirmViewControllerTest: XCTestCase {
    
    let confirmViewController = ConfirmViewController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testView() {
        
        confirmViewController.viewinit()
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSendButtonAction() {
//        confirmViewController.sendButtonAction()
//        confirmViewController.phoneNumberTextField.text = "000000"
//        confirmViewController.sendButtonAction()
        
        let networking = Networking()
//        networking.postConfirm(message: ["username" : "01029000019", "text" : "012345"])
        
        
        let expectation = XCTNSNotificationExpectation(name: "startCountTime", object: networking)
        XCTWaiter().wait(for: [expectation], timeout: 30)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
