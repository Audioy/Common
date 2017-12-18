//
//  UITextFieldWithRegexTests.swift
//  CommonTests
//
//  Created by John Neumann on 17/12/2017.
//  Copyright © 2017 Audioy. All rights reserved.
//

import XCTest
@testable import Common

class UITextFieldWithRegexTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testRegexNumber() {
        let textfield = UITextFieldWithRegex(.number)
        let testText = "A123"
        textfield.text = testText
        print(textfield.text!)
        XCTAssertEqual(textfield.text!, testText)
    }
    
}
