//
//  XMLConvertor.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/23.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import Foundation

struct XMLConvertor {
	var rules: [XMLConvertionRule]
	
	func convert(xmlToConvert: XMLObject) -> XMLObject {
		var resultObject = xmlToConvert
		for rule in rules {
			if let object = rule.applyRule(resultObject) as? XMLObject {
				resultObject = object
			} else {
				return xmlToConvert
			}
		}
		return resultObject
	}
	
	init(rules: [XMLConvertionRule]) {
		self.rules = rules
	}
}