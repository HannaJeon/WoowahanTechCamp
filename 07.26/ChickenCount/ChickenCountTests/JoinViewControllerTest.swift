//
//  JoinViewControllerTest.swift
//  ChickenCount
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import XCTest
import UIKit
@testable import ChickenCount

class JoinViewControllerTest: XCTestCase {
    let joinViewController = JoinViewController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCheckId() {
        XCTAssertTrue(joinViewController.checkId(id: "1234567890"), "아이디확인 실패")
        XCTAssertFalse(joinViewController.checkId(id: "가나다라마바사"), "아이디확인 실패")
        XCTAssertFalse(joinViewController.checkId(id: "asd"), "아이디확인 실패")
        XCTAssertFalse(joinViewController.checkId(id: "!@#$!@$@#%$&%^*^&(*)"), "아이디확인 실패")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCheckPassword() {
        XCTAssertFalse(joinViewController.checkPassword(id: "1234", password: "1234", passwordConfirm: "1234"), "비밀번호확인")
        XCTAssertTrue(joinViewController.checkPassword(id: "hanna", password: "123456", passwordConfirm: "123456"), "비밀번호확인")
        XCTAssertFalse(joinViewController.checkPassword(id: "hanna12", password: "hanna12", passwordConfirm: "hanna12"), "비밀번호확인")
        XCTAssertFalse(joinViewController.checkPassword(id: "hanna", password: "1234", passwordConfirm: "1234"), "비밀번호확인")
        XCTAssertFalse(joinViewController.checkPassword(id: "hanna", password: "1234", passwordConfirm: "123456"), "비밀번호확인")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
