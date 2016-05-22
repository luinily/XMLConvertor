//
//  XMLObject.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/22.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import Foundation

extension XMLObject: XMLPart {}

struct XMLObject {
	var elements = [XMLElement]()
	
	mutating func addElement(element: XMLElement) {
		elements.append(element)
	}
	
	func containsElement(element: XMLElement) -> Bool {
		return elements.contains(element)
	}
}