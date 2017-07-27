//
//  MainViewControllerTest.swift
//  ChickenCount
//
//  Created by woowabrothers on 2017. 7. 27..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import XCTest
import UIKit
@testable import ChickenCount

class MainViewControllerTest: XCTestCase {
    
    let mainViewController = MainViewController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCountdDay() {
        XCTAssertNil(mainViewController.countDday(selectedDay: nil), "nil임")
        XCTAssertNotNil(mainViewController.countDday(selectedDay: Date()), "현재날짜임")
        XCTAssertEqual(mainViewController.countDday(selectedDay: Date()), 0, "현재날짜임")
        XCTAssertEqual(mainViewController.countDday(selectedDay: Date(timeIntervalSinceNow: 172800)), 2, "2틀뒤")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
