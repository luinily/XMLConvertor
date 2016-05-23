//
//  XMLElementContent.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/22.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import Foundation

extension XMLElementContent: XMLElementContainer {
	func getElements() -> [XMLElement] {
		return elements
	}
	
	func getElementsCount() -> Int {
		return elements.count
	}
	
	mutating func addElement(element: XMLElement) {
		elements.append(element)
	}
	
	mutating func removeAll() {
		elements.removeAll()
	}
}

extension XMLElementContent: Equatable { }
func == (lhs: XMLElementContent, rhs: XMLElementContent) -> Bool {
	if lhs.elements.count != rhs.elements.count {
		return false
	}
	
	for i in [0...lhs.elements.count - 1] {
		if lhs.elements[i] != rhs.elements[i] {
			return false
		}
	}
	
	return true
}
	
extension XMLElementContent: XMLContent {
	
}

struct XMLElementContent {
	var elements: [XMLElement]
	var count: Int {return elements.count}
	
	init(elements: [XMLElement]) {
		self.elements = elements
	}
	
	init() {
		self.elements = [XMLElement]()
	}
	
	mutating func removeElement(elementToRemove: XMLElement) {
		var removedElement = true
		while removedElement {
			removedElement = tryRemoveFirstOccurenceOfElement(elementToRemove)
		}
	}
	
	mutating func tryRemoveFirstOccurenceOfElement(elementToRemove: XMLElement) -> Bool {
		let index = elements.indexOf() {
			(element) -> Bool in
			if elementToRemove == element {
				return true
			}
			return false
		}
		if let index = index {
			elements.removeAtIndex(index)
			return true
		}
		return false
	}
}