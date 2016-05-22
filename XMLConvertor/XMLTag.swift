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
	return (lhs.tag == rhs.tag)
	
}

extension XMLTag: XMLPart {
	
}

struct XMLTag {
	var tag: String
	
	init(tag: String) {
		self.tag = tag
	}
}