//
//  XMLTextContentTest.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/22.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import XCTest
@testable import XMLConvertor

class XMLTextContentTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	func testEquatable_Equals() {
		let a = XMLTextContent(text: "a")
		let c = a
		
		XCTAssertEqual(a, c)
	}
	
	func testEquatable_notEquals() {
		let a = XMLTextContent(text: "a")
		let b = XMLTextContent(text: "b")
		
		XCTAssertNotEqual(a, b)
	}
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
