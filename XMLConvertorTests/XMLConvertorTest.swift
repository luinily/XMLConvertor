//
//  XMLConvertorTest.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/23.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import XCTest
@testable import XMLConvertor

class XMLConvertorTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	class ConvertorSpy: XMLConvertionRule {
		var didCallRule = false
		
		func applyRule(xmlPart: XMLPart) -> XMLPart {
			didCallRule = true
			let tag = XMLTag(name: "tag")
			let attribute = XMLAttribute(attribute: "attribute", value: "value")
			let attributes = [attribute]
			let content = XMLTextContent(text: "content")
			let element = XMLElement(tag: tag, attributes: attributes, content: content)
			
			return XMLObject(elements: [element])
		}
	}

    func testDidCallRule() {
		let spy = ConvertorSpy()
        let convertor = XMLConvertor(rules: [spy])
		let xmlObject = XMLObject()
		convertor.convert(xmlObject)
		
		XCTAssertTrue(spy.didCallRule)
    }
	
	func testDidReturnConversionResult() {
		let spy = ConvertorSpy()
		let convertor = XMLConvertor(rules: [spy])
		let xmlObject = XMLObject()
		let resultXMLObject = convertor.convert(xmlObject)
		
		if let resultElement = resultXMLObject.elements.first {
			XCTAssertEqual(resultElement.tag.name, "tag")
		}
	}

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
