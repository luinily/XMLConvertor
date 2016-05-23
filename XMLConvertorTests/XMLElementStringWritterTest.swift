//
//  XMLElementStringWritterTest.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/24.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import XCTest
@testable import XMLConvertor

class XMLElementStringWriterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testWriteElement_tagOnly() {
		let tag = XMLTag(name: "tag")
		let element = XMLElement(tag: tag, attributes: [])
		let writter = XMLElementStringWriter()
		
		let resultSting = writter.write(element)
		
		XCTAssertEqual(resultSting, "<tag />\r\n")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
	
	func testWriteElement_withAttributes() {
		let tag = XMLTag(name: "tag")
		let attributeA = XMLAttribute(attribute: "attributeA", value: "A")
		let attributeB = XMLAttribute(attribute: "attributeB", value: "B")
		let element = XMLElement(tag: tag, attributes: [attributeA, attributeB])
		let writter = XMLElementStringWriter()
		
		let resultSting = writter.write(element)
		let expectedString = "<tag attributeA=\"A\" attributeB=\"B\" />\r\n"
		XCTAssertEqual(resultSting, expectedString)
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
	}
	
	func testWriteElement_withStringContent() {
		let tag = XMLTag(name: "tag")
		let attributeA = XMLAttribute(attribute: "attributeA", value: "A")
		let attributeB = XMLAttribute(attribute: "attributeB", value: "B")
		let content = XMLTextContent(text: "Content.")
		let element = XMLElement(tag: tag, attributes: [attributeA, attributeB], content: content)
		let writter = XMLElementStringWriter()
		
		let resultSting = writter.write(element)
		let expectedString = "<tag attributeA=\"A\" attributeB=\"B\">\r\n" + "\tContent.\r\n" + "</tag>\r\n"
		
		XCTAssertEqual(resultSting, expectedString)
	}
	
	func testWriteElement_withElementContent() {
		let tag = XMLTag(name: "tag")
		let attributeA = XMLAttribute(attribute: "attributeA", value: "A")
		let attributeB = XMLAttribute(attribute: "attributeB", value: "B")
		
		let subTag = XMLTag(name: "subElement")
		let subElement1 = XMLElement(tag: subTag, attributes: [])
		let subElement2 = XMLElement(tag: subTag, attributes: [])
		let elementContent = XMLElementContent(elements: [subElement1, subElement2])
		let element = XMLElement(tag: tag, attributes: [attributeA, attributeB], content: elementContent)
		let writter = XMLElementStringWriter()
		
		let resultSting = writter.write(element)
		var expectedString = "<tag attributeA=\"A\" attributeB=\"B\">\r\n"
		expectedString = expectedString	+ "\t<subElement />\r\n"
		expectedString = expectedString	+ "\t<subElement />\r\n"
		expectedString = expectedString	+ "</tag>\r\n"
		
		XCTAssertEqual(resultSting, expectedString)
	}
	
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
