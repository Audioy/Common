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
    func testRegexNumber() {
        let textfield = UITextFieldWithRegex(.number)
        let testText = "A123"
        textfield.text = testText
        XCTAssertEqual(textfield.text!, testText)
    }
    
}
