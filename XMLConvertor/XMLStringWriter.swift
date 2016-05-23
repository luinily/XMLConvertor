//
//  XMLStringWriter
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/24.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import Foundation

class XMLStringWriter {
	func write(xmlObject: XMLObject) -> String {
		var string = ""
		let elementWritter = XMLElementStringWriter()
		for element in xmlObject.getElements() {
			string = string + elementWritter.write(element)
		}
		return string
	}
}

