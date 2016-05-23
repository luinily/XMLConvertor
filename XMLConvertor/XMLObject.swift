//
//  XMLObject.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/22.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import Foundation

extension XMLObject: XMLPart {}

extension XMLObject: XMLElementContainer {
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

struct XMLObject {
	var elements = [XMLElement]()
}