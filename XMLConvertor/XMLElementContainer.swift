//
//  XMLElementContainer.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/23.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import Foundation

protocol XMLElementContainer {
	func getElements() -> [XMLElement]
	func getElementsCount() -> Int
	
	mutating func addElement(element: XMLElement)
	
	mutating func removeAll()
	
	func containsElement(element: XMLElement) -> Bool
}

extension XMLElementContainer {
	func containsElement(element: XMLElement) -> Bool {
		return getElements().contains(element)
	}
}