//
//  XMLTag.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/22.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import Foundation

extension XMLTag: Equatable {
	
}

func == (lhs: XMLTag, rhs: XMLTag) -> Bool {
	return (lhs.name == rhs.name)
	
}

extension XMLTag: XMLPart {
	
}

struct XMLTag {
	var name: String
	
	init(name: String) {
		self.name = name
	}
}