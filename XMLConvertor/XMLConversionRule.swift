//
//  XMLConversionRule.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/23.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import Foundation

protocol XMLConvertionRule {
	func applyRule(xmlPart: XMLPart) -> XMLPart 
}