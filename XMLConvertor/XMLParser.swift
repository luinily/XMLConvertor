//
//  XMLParser.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/23.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import Foundation

class XMLParser: NSObject {
	private var _root = false
	private var _elements = [XMLElement]()
	private var _tag: XMLTag?
	private var _attributes = [XMLAttribute]()
	private var _elementContent: XMLElementContent?
	private var _textContent: XMLTextContent?
	private var _parentParser: XMLParser?
	private var _currentChildParser: XMLParser?
	private var _parser: NSXMLParser?
	private var _completionHandler: ((xmlObject: XMLObject) -> Void)?

	override init() {
		_parser = nil
		_root = true
		super.init()
	}
	
	init(parser: NSXMLParser, parentParser: XMLParser, tag: XMLTag, attributes: [XMLAttribute]) {
		_parser = parser
		_parentParser = parentParser
		_tag = tag
		_attributes = attributes
		_root = false
		super.init()
		
		_parser?.delegate = self
	}
	
	func readXML(url: NSURL, completionHandler: (xmlObject: XMLObject) -> Void) {
		_parser = NSXMLParser(contentsOfURL: url)
		_completionHandler = completionHandler
		parse()
	}
	
	func readXML(data: NSData, completionHandler: (xmlObject: XMLObject) -> Void) {
		_parser = NSXMLParser(data: data)
		_completionHandler = completionHandler
		parse()
	}
	
	func readXML(stream: NSInputStream, completionHandler: (xmlObject: XMLObject) -> Void) {
		_parser = NSXMLParser(stream: stream)
		_completionHandler = completionHandler
		parse()
	}
	
	private func parse() {
		_parser?.delegate = self
		_parser?.parse()
	}
	
	private func elementCompleted(newElement: XMLElement) {
		if _elementContent == nil {
			_elementContent = XMLElementContent()
		}
		_elementContent?.addElement(newElement)
		_parser?.delegate = self
	}
	
}

extension XMLParser: NSXMLParserDelegate {
	func parserDidStartDocument(parser: NSXMLParser) {
		print("start documet pars")
	}
	
	func parserDidEndDocument(parser: NSXMLParser) {
		let xmlObject = XMLObject(elements: _elements)
		_completionHandler?(xmlObject: xmlObject)
	}
	
	func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
		if _root {
			startElement(elementName, attributeDict: attributeDict)
		} else {
			startContentElement(elementName, attributeDict: attributeDict)
		}
	}
	
	func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		if let newElement = makeNewElement() {
			if _root {
				_elements.append(newElement)
			} else {
				_parentParser?.elementCompleted(newElement)
			}
		}
		
	}
	
	func parser(parser: NSXMLParser, foundCharacters string: String) {
		if _textContent == nil {
			_textContent = XMLTextContent(text: string)
		} else if let currentContent = _textContent {
			_textContent = XMLTextContent(text: currentContent.text + string)
		}
	}
	
	private func makeNewElement() -> XMLElement? {
		if let tag = _tag {
			if let elementContent = _elementContent {
				return XMLElement(tag: tag, attributes: _attributes, content: elementContent)
			} else if let textContent = _textContent {
				return XMLElement(tag: tag, attributes: _attributes, content: textContent)
			} else {
				return XMLElement(tag: tag, attributes: _attributes)
			}
		}
		return nil
	}
	
	private func startContentElement(elementName: String, attributeDict: [String : String]) {
		let tag = XMLTag(name: elementName)
		var attributes = [XMLAttribute]()
		for attribute in attributeDict {
			attributes.append(XMLAttribute(attribute: attribute.0, value: attribute.1))
		}
		if let parser = _parser {
			_currentChildParser = XMLParser(parser: parser, parentParser: self, tag: tag, attributes: attributes)
		}
	}
	
	private func startElement(elementName: String, attributeDict: [String : String]) {
		_tag = XMLTag(name: elementName)
		var attributes = [XMLAttribute]()
		for attribute in attributeDict {
			attributes.append(XMLAttribute(attribute: attribute.0, value: attribute.1))
		}
	}
}