//
//  XMLElement.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/22.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import Foundation

extension XMLElement: Equatable { }
func == (lhs: XMLElement, rhs: XMLElement) -> Bool {
	return (lhs.tag == rhs.tag) && (lhs.attributes == rhs.attributes) && (lhs.content.equals(rhs.content))
	
}

extension XMLElement: XMLPart { }

struct XMLElement {
	var tag: XMLTag
	var attributes = [XMLAttribute]()
	var attributesCount: Int {return attributes.count}
	var content: XMLContent
	
	init(tag: XMLTag, attributes: [XMLAttribute], content: XMLContent) {
		self.tag = tag
		self.attributes = attributes
		self.content = content
	}
	
	mutating func tryAddAttribute(attribute: XMLAttribute) -> Bool {
		if attributes.contains(attribute) {
			return false
		}
		
		attributes.append(attribute)
		return true
	}
	
	mutating func removeAttribute(attribute: XMLAttribute) {
		if let index = attributes.indexOf(attribute) {
			attributes.removeAtIndex(index)
		}
	}
	
	func hasAttribute(attributeName: String) -> Bool {
		let indexOfAttribute = attributes.indexOf() {
			attribute in
			return attribute.attribute == attributeName
		}
		
		return indexOfAttribute != nil
	}
}

