//
//  XMLElementContentTest.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/22.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import XCTest
@testable import XMLConvertor

class XMLElementContentTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testEquatable_Equals_TextContent() {
		let tag = XMLTag(name: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		
		let element = XMLElement(tag: tag, attributes: attributes, content: content)
		var a = XMLElementContent()
		a.addElement(element)
		let c = a
		
		XCTAssertEqual(a, c)
	}
	
	func testEquatable_notEquals() {
		let aTag = XMLTag(name: "aTag")
		let aAttribute = XMLAttribute(attribute: "aAttribute", value: "aValue")
		let aAttributes = [aAttribute]
		let aContent = XMLTextContent(text: "aContent")
		let aElement = XMLElement(tag: aTag, attributes: aAttributes, content: aContent)
		var a = XMLElementContent()
		a.addElement(aElement)
		
		let bTag = XMLTag(name: "bTag")
		let bAttribute = XMLAttribute(attribute: "bAttribute", value: "bValue")
		let bAttributes = [bAttribute]
		let bContent = XMLTextContent(text: "bContent")
		let bElement = XMLElement(tag: bTag, attributes: bAttributes, content: bContent)
		var b = XMLElementContent()
		b.addElement(bElement)
		
		XCTAssertNotEqual(a, b)
	}
	
	func testEquatable_differentElementCount() {
		let tag = XMLTag(name: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		let element = XMLElement(tag: tag, attributes: attributes, content: content)
		
		var a = XMLElementContent()
		a.addElement(element)
		var b = XMLElementContent()
		b.addElement(element)
		b.addElement(element)
		
		XCTAssertNotEqual(a, b)
	}
	
	func testRemoveElement() {
		let tag = XMLTag(name: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		let element = XMLElement(tag: tag, attributes: attributes, content: content)
		var elementB = element
		elementB.tag = XMLTag(name: "tagB")
		let elements = [element, elementB, element]
		
		var elementContent = XMLElementContent(elements: elements)
		
		elementContent.removeElement(element)
		XCTAssertEqual(elementContent.count, 1)
	}
	
	func testAddElement() {
		let tag = XMLTag(name: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		let element = XMLElement(tag: tag, attributes: attributes, content: content)
		
		var elementContent = XMLElementContent()
		elementContent.addElement(element)
		elementContent.addElement(element)
		elementContent.addElement(element)
		XCTAssertEqual(elementContent.count, 3)
	}
	
	func testContainsElement_true() {
		let tag = XMLTag(name: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		let element = XMLElement(tag: tag, attributes: attributes, content: content)
		var elementB = element
		elementB.tag = XMLTag(name: "tagB")
		let elements = [element, elementB, element]
		
		let elementContent = XMLElementContent(elements: elements)
		
		XCTAssertTrue(elementContent.containsElement(elementB))
	}
	
	func testContainsElement_false() {
		let tag = XMLTag(name: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		let element = XMLElement(tag: tag, attributes: attributes, content: content)
		var elementB = element
		elementB.tag = XMLTag(name: "tagB")
		let elements = [element, element]
		
		let elementContent = XMLElementContent(elements: elements)
		
		XCTAssertFalse(elementContent.containsElement(elementB))
	}
	
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
