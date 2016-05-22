//
//  XMLElementTest.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/22.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import XCTest
@testable import XMLConvertor

class XMLElementTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	func testEquatable_Equals_TextContent() {
		let tag = XMLTag(tag: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		
		let a = XMLElement(tag: tag, attributes: attributes, content: content)
		let c = a
		
		XCTAssertEqual(a, c)
	}
	
	func testEquatable_Equals_ElementContent() {
		let tag = XMLTag(tag: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		
		let elementTag = XMLTag(tag: "elementTag")
		let elementAttribute = XMLAttribute(attribute: "elementAttribute", value: "elementValue")
		let elementAttributes = [elementAttribute]
		let elementContent = XMLTextContent(text: "elementContent")
		let element = XMLElement(tag: elementTag, attributes: elementAttributes, content: elementContent)
		
		var content = XMLElementContent()
		content.addElement(element)
		
		let a = XMLElement(tag: tag, attributes: attributes, content: content)
		let c = a
		
		XCTAssertEqual(a, c)

	}
	
	func testEquatable_notEquals() {
		let aTag = XMLTag(tag: "aTag")
		let aAttribute = XMLAttribute(attribute: "aAttribute", value: "aValue")
		let aAttributes = [aAttribute]
		let aContent = XMLTextContent(text: "aContent")
		let a = XMLElement(tag: aTag, attributes: aAttributes, content: aContent)
		
		let bTag = XMLTag(tag: "bTag")
		let bAttribute = XMLAttribute(attribute: "bAttribute", value: "bValue")
		let bAttributes = [bAttribute]
		let bContent = XMLTextContent(text: "bContent")
		let b = XMLElement(tag: bTag, attributes: bAttributes, content: bContent)
		
		XCTAssertNotEqual(a, b)
	}
	
	func testEquatable_notSameContentType() {
		let tag = XMLTag(tag: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		let a = XMLElement(tag: tag, attributes: attributes, content: content)
		
		let bTag = XMLTag(tag: "bTag")
		let bAttribute = XMLAttribute(attribute: "bAttribute", value: "bValue")
		let bAttributes = [bAttribute]
		let bContent = XMLTextContent(text: "bContent")
		let b = XMLElement(tag: bTag, attributes: bAttributes, content: bContent)
		
		XCTAssertNotEqual(a, b)
	}
	
	func testEquatable_differentAttributescount() {
		let tag = XMLTag(tag: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		var attributes = [attribute]
		let content = XMLTextContent(text: "content")
		
		let a = XMLElement(tag: tag, attributes: attributes, content: content)
		
		attributes.append(attribute)
		let c = XMLElement(tag: tag, attributes: attributes, content: content)
		
		XCTAssertNotEqual(a, c)
	}
	
	func testAddAttribute() {
		let tag = XMLTag(tag: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [XMLAttribute]()
		let content = XMLTextContent(text: "content")
		var element = XMLElement(tag: tag, attributes: attributes, content: content)
		element.tryAddAttribute(attribute)
		
		XCTAssertEqual(element.attributesCount, 1)
	}
	
	func testRemoveAttribute() {
		//Giver
		let tag = XMLTag(tag: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attribute2 = XMLAttribute(attribute: "attribute2", value: "value2")
		let attributes = [attribute, attribute2]
		let content = XMLTextContent(text: "content")
		var element = XMLElement(tag: tag, attributes: attributes, content: content)
		
		//When
		element.removeAttribute(attribute2)
		
		//Then
		XCTAssertEqual(element.attributesCount, 1)
	}
	
	func testCannotAddSameAttribute() {
		let tag = XMLTag(tag: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		var element = XMLElement(tag: tag, attributes: attributes, content: content)
		let couldAdd = element.tryAddAttribute(attribute)
		
		XCTAssertFalse(couldAdd)
		XCTAssertEqual(element.attributesCount, 1)
	}
	
	func testHasAttribute_true() {
		let tag = XMLTag(tag: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		let element = XMLElement(tag: tag, attributes: attributes, content: content)
		
		let hasAttribute = element.hasAttribute(attribute.attribute)
		
		XCTAssertTrue(hasAttribute)
	}
	
	func testHasAttribute_false() {
		let tag = XMLTag(tag: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		let element = XMLElement(tag: tag, attributes: attributes, content: content)
		
		let hasAttribute = element.hasAttribute("nonExistingAttribute")
		
		XCTAssertFalse(hasAttribute)
	}
	
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
