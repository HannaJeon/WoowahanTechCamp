//
//  DatePickerViewControllerTest.swift
//  ChickenCount
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import XCTest
import UIKit
@testable import ChickenCount

class DatePickerViewControllerTest: XCTestCase {
    
    let datePickerViewController = DatePickerViewController()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConfirm() {
        XCTAssertFalse(datePickerViewController.confirm(selectedDate: Date()), "에러 : 오늘 날짜 허용됨")
        XCTAssertFalse(datePickerViewController.confirm(selectedDate: Date(timeIntervalSince1970: 0)), "에러 : 과거날짜임")
        XCTAssertTrue(datePickerViewController.confirm(selectedDate: Date(timeInterval: 86400000, since: Date())), "미래날짜임")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
