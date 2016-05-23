//
//  XMLElementStringWritter.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/24.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import Foundation

class XMLElementStringWriter {
	func write(element: XMLElement) -> String {
		if element.content == nil {
			return writeElementWithoutContent(element)
		} else {
			return writeElementWithContent(element)
		}
		
	}
	
	private func writeElementWithoutContent(element: XMLElement) -> String {
		var string = "<" + writeTag(element)
		string = string + writeAttributes(element)
		string = string + " />\r\n"
		
		return string
	}
	
	private func writeElementWithContent(element: XMLElement) -> String {
		var string = writeStartTag(element)
		string = string + writeContent(element)
		string = string + writeEndTag(element)
		return string
	}
	
	private func writeStartTag(element: XMLElement) -> String {
		var string = "<" + writeTag(element)
		string = string + writeAttributes(element)
		string = string + ">\r\n"
		
		return string
	}
	
	private func writeEndTag(element: XMLElement) -> String {
		return "</" + writeTag(element) + ">\r\n"
	}
	
	private func writeTag(element: XMLElement) -> String {
		return element.tag.name
	}
	
	private func writeAttributes(element: XMLElement) -> String {
		var string = ""
		for attribute in element.attributes {
			string = string + " " + attribute.attribute + "=\"" + attribute.value + "\""
		}
		return string
	}
	
	private func writeContent(element: XMLElement) -> String {
		if let textContent = element.content as? XMLTextContent {
			return writeTextContent(textContent)
		}
		
		if let elementContent = element.content as? XMLElementContent {
			return writeElementContent(elementContent)
		}
		
		return ""
	}
	
	private func writeTextContent(textContent: XMLTextContent) -> String {
		return "\t" + textContent.text + "\r\n"
	}
	
	private func writeElementContent(elementContent: XMLElementContent) -> String {
		var string = ""
		for element in elementContent.elements {
			string = string + "\t" + write(element)
		}
		return string
	}
}