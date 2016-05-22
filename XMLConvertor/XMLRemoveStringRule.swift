//
//  XMLRemoveStringRule.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/23.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import Foundation

struct XMLRemoveStringRule: XMLConvertionRule {
	private let _stringToRemove: String
	
	init(stringToRemove: String) {
		_stringToRemove = stringToRemove
	}
	
	func  applyRule(xmlPart: XMLPart) -> XMLPart {
		if let element = xmlPart as? XMLElement {
			let elementAfterAttributeFilter = applyRuleOnAttributes(element)
			let elementAfterContentFilter = applyRuleOnContent(elementAfterAttributeFilter)
			
			return elementAfterContentFilter
		}
		
		return xmlPart
	}
	
	private func applyRuleOnAttributes(element: XMLElement) -> XMLElement {
		var result = element
		for attribute in result.attributes {
			if attribute.attribute == _stringToRemove {
				result.removeAttribute(attribute)
			}
			
			if attribute.value == _stringToRemove {
				result.removeAttribute(attribute)
			}
		}
		return result
	}
	
	private func applyRuleOnContent(element: XMLElement) -> XMLElement {
		switch element.content {
		case is XMLElementContent: return applyRuleOnElementContent(element)
		case is XMLTextContent: return applyRuleOnTextAttribute(element)
		default: return element
		}
	}
	
	private func applyRuleOnTextAttribute(element: XMLElement) -> XMLElement {
		if let textContent = element.content as? XMLTextContent {
			if let range = textContent.text.rangeOfString(_stringToRemove) {
				var newContentText = textContent.text
				newContentText.removeRange(range)
				var resultElement = element
				resultElement.content = XMLTextContent(text: newContentText)
				
				return resultElement
			}
		}
		return element
	}
	
	private func applyRuleOnElementContent(element: XMLElement) -> XMLElement {
		if var elementContent = element.content as? XMLElementContent {
			for element in elementContent.elements {
				if element.tag.tag == _stringToRemove {
					elementContent.removeElement(element)
				}
			}
			var resultElement = element
			resultElement.content = elementContent
			return resultElement
		}
		return element
	}
}