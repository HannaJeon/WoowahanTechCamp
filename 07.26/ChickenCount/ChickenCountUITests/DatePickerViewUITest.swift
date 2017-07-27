//
//  DatePickerViewUITest.swift
//  ChickenCount
//
//  Created by woowabrothers on 2017. 7. 27..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import XCTest
import UIKit
@testable import ChickenCount

class DatePickerViewUITest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        XCUIApplication().launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels["2017년"].swipeDown()
        
        let doneButton = app.buttons["Done"]
        doneButton.tap()
        
        let okButton = app.alerts["경고!!!!!"].buttons["OK"]
        okButton.tap()
        datePickersQuery.pickerWheels["2008년"].swipeUp()
        datePickersQuery.pickerWheels["2010년"].swipeUp()
        
        let pickerWheel = datePickersQuery.pickerWheels["2019년"]
        pickerWheel.swipeDown()
        datePickersQuery.pickerWheels["2001년"].tap()
        doneButton.tap()
        okButton.tap()
        datePickersQuery.pickerWheels["2000년"].swipeUp()
        datePickersQuery.pickerWheels["2002년"].swipeUp()
        pickerWheel.tap()
        doneButton.tap()
    }
    
}
