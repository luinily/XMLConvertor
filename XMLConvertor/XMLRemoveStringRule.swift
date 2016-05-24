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
		if let object = xmlPart as? XMLObject {
			return applyRuleOnXMLObject(object)
		}
		
		if let element = xmlPart as? XMLElement {
			return applyRuleOnXMLElement(element)
		}
		
		return xmlPart
	}
	
	private func applyRuleOnXMLObject(object: XMLObject) -> XMLObject {
		if let resultObject = applyRuleOnElementContainer(object) as? XMLObject {
			return resultObject
		}
		
		return object
	}
	
	private func applyRuleOnXMLElement(element: XMLElement) -> XMLElement {
		let elementAfterTagFilter = applyRuleOnTag(element)
		let elementAfterAttributeFilter = applyRuleOnAttributes(elementAfterTagFilter)
		let elementAfterContentFilter = applyRuleOnContent(elementAfterAttributeFilter)
		
		return elementAfterContentFilter
	}
	
	private func applyRuleOnTag(element: XMLElement) -> XMLElement {
		if element.tag.name == _stringToRemove {
			return element
		}
		
		if element.tag.name.containsString(_stringToRemove) {
			var name = element.tag.name
			if let range = name.rangeOfString(_stringToRemove) {
				name.removeRange(range)
				let newTag = XMLTag(name: name)
				var resultElement = element
				resultElement.tag = newTag
				return resultElement
			}
		}
		
		return element
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
		if let elementContent = element.content as? XMLElementContent {
			if let resultContent = applyRuleOnElementContainer(elementContent) as? XMLElementContent {
				var resultElement = element
				resultElement.content = resultContent
				return resultElement
			}
		}
		return element
	}
	
	private func applyRuleOnElementContainer(elementContainer: XMLElementContainer) -> XMLElementContainer {
		var resultElementContainer = elementContainer
		
		resultElementContainer.removeAll()
		for element in elementContainer.getElements() {
			if element.tag.name == _stringToRemove {
				//if the element tag is the string we remove the element, no need to re-add it.
			} else {
 			if let element = applyRule(element) as? XMLElement {
				resultElementContainer.addElement(element)
				}
			}
		}
		return resultElementContainer
	}
}