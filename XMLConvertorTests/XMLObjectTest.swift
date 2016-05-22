//
//  XMLObjectTest.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/23.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import XCTest
@testable import XMLConvertor

class XMLObjectTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testContainsElement_true() {
		let tag = XMLTag(tag: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		let element = XMLElement(tag: tag, attributes: attributes, content: content)
		var elementB = element
		elementB.tag = XMLTag(tag: "tagB")
		
		let xmlObject = XMLObject(elements: [element, elementB])
		
		XCTAssertTrue(xmlObject.containsElement(elementB))
	}
	
	func testContainsElement_false() {
		let tag = XMLTag(tag: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		let element = XMLElement(tag: tag, attributes: attributes, content: content)
		var elementB = element
		elementB.tag = XMLTag(tag: "tagB")
		
		let xmlObject = XMLObject(elements: [element, element])
		
		XCTAssertFalse(xmlObject.containsElement(elementB))
	}

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
