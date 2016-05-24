//
//  XMLRemoveStringRuleTest.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/23.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import XCTest
@testable import XMLConvertor

class XMLRemoveStringRuleTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testApplyRule_removeAttribute_Name() {
		let tag = XMLTag(name: "tag")
		let attribute1 = XMLAttribute(attribute: "attribute", value: "value")
		let attribute2 = XMLAttribute(attribute: "attribute2", value: "value2")
		let attribute3 = XMLAttribute(attribute: "attribute3", value: "value3")
		let attributes = [attribute1, attribute2, attribute3]
		let content = XMLTextContent(text: "content")
		
		let element = XMLElement(tag: tag, attributes: attributes, content: content)
		
		let rule = XMLRemoveStringRule(stringToRemove: "attribute2")
		if let result = rule.applyRule(element) as? XMLElement {
			XCTAssertFalse(result.hasAttribute("attribute2"))
		} else {
			XCTAssert(false)
		}
		
    }
	
	func testApplyRule_removeAttribute_Value() {
		let tag = XMLTag(name: "tag")
		let attribute1 = XMLAttribute(attribute: "attribute", value: "value")
		let attribute2 = XMLAttribute(attribute: "attribute2", value: "value2")
		let attribute3 = XMLAttribute(attribute: "attribute3", value: "value3")
		let attributes = [attribute1, attribute2, attribute3]
		let content = XMLTextContent(text: "content")
		
		let element = XMLElement(tag: tag, attributes: attributes, content: content)
		
		let rule = XMLRemoveStringRule(stringToRemove: "value2")
		if let result = rule.applyRule(element) as? XMLElement {
			XCTAssertFalse(result.hasAttribute("attribute2"))
		} else {
			XCTAssert(false)
		}
	}
	
	func testApplyRule_removeFromContent_Text() {
		// With
		let tag = XMLTag(name: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content content2 content3")
		
		let element = XMLElement(tag: tag, attributes: attributes, content: content)
		
		// When
		let rule = XMLRemoveStringRule(stringToRemove: "content2 ")
		
		// Then
		if let result = rule.applyRule(element) as? XMLElement {
			if let textContent = result.content as? XMLTextContent {
				XCTAssertTrue(textContent.text == "content content3")
				return
			}
		}

		XCTAssert(false)
	}
	
	func testApplyRule_removeFromContent_Element() {
		// With
		let tag = XMLTag(name: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		let elementA = XMLElement(tag: tag, attributes: attributes, content: content)
		
		let tagB = XMLTag(name: "tagB")
		let elementB = XMLElement(tag: tagB, attributes: attributes, content: content)
		
		let elementContent = XMLElementContent(elements: [elementA, elementB])
		let element = XMLElement(tag: tagB, attributes: attributes, content: elementContent)
		
		// When
		let rule = XMLRemoveStringRule(stringToRemove: "tagB")
		
		// Then
		if let result = rule.applyRule(element) as? XMLElement {
			if let resultElementContent = result.content as? XMLElementContent {
				XCTAssertFalse(resultElementContent.containsElement(elementB))
				return
			}
		}
		
		XCTAssert(false)
	}
	
	func textApplyRule_removeFromXMLObject() {
		// With
		let tag = XMLTag(name: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		let elementA = XMLElement(tag: tag, attributes: attributes, content: content)
		
		let tagB = XMLTag(name: "tagB")
		let elementB = XMLElement(tag: tagB, attributes: attributes, content: content)
		
		let xmlObject = XMLObject(elements: [elementA, elementB])
		
		// When
		let rule = XMLRemoveStringRule(stringToRemove: "tagB")
		
		// Then
		if let result = rule.applyRule(xmlObject) as? XMLObject {
			XCTAssertFalse(result.containsElement(elementB))
			return
		}
		
		XCTAssert(false)
	}

	func testRuledAppliedToElementsInXMLObject() {
		// With
		let tag = XMLTag(name: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content string to remove")
		let elementA = XMLElement(tag: tag, attributes: attributes, content: content)
		
		let tagB = XMLTag(name: "tagB")
		let elementB = XMLElement(tag: tagB, attributes: attributes, content: content)
		
		let xmlObject = XMLObject(elements: [elementA, elementB])
		
		// When
		let rule = XMLRemoveStringRule(stringToRemove: " string to remove")
		
		// Then
		if let result = rule.applyRule(xmlObject) as? XMLObject {
			let element = result.elements.first
			if let elementContent = element?.content as? XMLTextContent {
				XCTAssertEqual(elementContent.text, "content")
			}
			return
		}
		
		XCTAssert(false)
	}
	
	func testRuleAppliedToElementsInElementContent() {
		// With
		let tag = XMLTag(name: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content string to remove")
		let elementA = XMLElement(tag: tag, attributes: attributes, content: content)
		
		let tagB = XMLTag(name: "tagB")
		let elementB = XMLElement(tag: tagB, attributes: attributes, content: content)
		
		let xmlElementContent = XMLElementContent(elements: [elementA, elementB])
		let element = XMLElement(tag: tag, attributes: attributes, content: xmlElementContent)
		// When
		let rule = XMLRemoveStringRule(stringToRemove: " string to remove")
		
		// Then
		if let resultElement = rule.applyRule(element) as? XMLElement {
			if let elementContent = resultElement.content as? XMLElementContent {
				let element = elementContent.elements.first
				if let elementContent = element?.content as? XMLTextContent {
					XCTAssertEqual(elementContent.text, "content")
				}
			}
			return
		}
		
		XCTAssert(false)
	}
	
	func testRuleRemoveStringFromElementName() {
		// With
		let tag = XMLTag(name: "tag")
		let attribute = XMLAttribute(attribute: "attribute", value: "value")
		let attributes = [attribute]
		let content = XMLTextContent(text: "content")
		let elementA = XMLElement(tag: tag, attributes: attributes, content: content)
		
		let tagB = XMLTag(name: "tagB")
		let elementB = XMLElement(tag: tagB, attributes: attributes, content: content)
		
		let elementContent = XMLElementContent(elements: [elementA, elementB])
		let element = XMLElement(tag: tagB, attributes: attributes, content: elementContent)
		
		// When
		let rule = XMLRemoveStringRule(stringToRemove: "ta")
		
		// Then
		if let result = rule.applyRule(element) as? XMLElement {
			XCTAssertEqual(result.tag.name, "gB")
			return
		}
		
		XCTAssert(false)
	}
	
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
	
	

}
