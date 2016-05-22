//
//  XMLContent.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/22.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import Foundation

extension XMLContent where Self: Equatable {
	func equals(other: XMLContent) -> Bool {
		if let other = other as? Self {
			return self == other
		}
		return false
	}
}

protocol XMLContent {
	func equals(other: XMLContent) -> Bool
}