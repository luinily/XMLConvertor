//
//  XMLTextContent.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/22.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import Foundation

extension XMLTextContent: Equatable {
	
}

func == (lhs: XMLTextContent, rhs: XMLTextContent) -> Bool {
	return lhs.text == rhs.text
}

extension XMLTextContent: XMLContent {
	
}

struct XMLTextContent {
	var text: String
	
	init(text: String) {
		self.text = text
	}
}