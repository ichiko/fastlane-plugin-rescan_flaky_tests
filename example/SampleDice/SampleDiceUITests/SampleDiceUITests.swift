//
//  SampleDiceUITests.swift
//  SampleDiceUITests
//
//  Created by ichiko on 2018/03/14.
//  Copyright © 2018年 ichiko_revjune. All rights reserved.
//

import XCTest

class SampleDiceUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        continueAfterFailure = true
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testButtonLabel() {
        let button = app.buttons["button_throw"]
        XCTAssertTrue(button.isEnabled)
        XCTAssertEqual(button.label, "ダイスを振る")
    }

    // Should Not wirte tests like this!!
    func testDiceReturned() {
        let button = app.buttons["button_throw"]
        let result = app.staticTexts["label_result"]

        button.tap()
        XCTAssertEqual(result.label, "3")
    }
    
}
