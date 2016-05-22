//
//  XMLAttribute.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/22.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import Foundation

extension XMLAttribute: Equatable {
	
}

func == (lhs: XMLAttribute, rhs: XMLAttribute) -> Bool {
	return (lhs.attribute == rhs.attribute) && (lhs.value == rhs.value)
}

struct XMLAttribute {
	var attribute: String
	var value: String
	
	init(attribute: String, value: String) {
		self.attribute = attribute
		self.value = value
	}
}
