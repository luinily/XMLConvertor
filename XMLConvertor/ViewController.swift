//
//  ViewController.swift
//  XMLConvertor
//
//  Created by Coldefy Yoann on 2016/05/22.
//  Copyright © 2016年 YoannColdefy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var urlTextField: UITextField!
	@IBOutlet weak var stringTextField: UITextField!
	@IBOutlet weak var convertButton: UIButton!
	@IBOutlet weak var outputTextBox: UITextView!
	
	private var _url : NSURL? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		convertButton.enabled = false
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	@IBAction func urlEditingDidEnd(sender: AnyObject) {
		if let text = urlTextField.text {
			if let url = NSURL(string: text) {
				_url = url
				convertButton.enabled = true
				return
			}
		}
		convertButton.enabled = false
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func convertClicked(sender: AnyObject) {
		if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
			if let url = _url, string = stringTextField.text {
				appDelegate.convertXML(url, stringToRemove: string) {
					xmlObject in
					let writer = XMLStringWriter()
					let xmlString = writer.write(xmlObject)
					
					self.outputTextBox.text = xmlString
				}
			}
		}
	}

}

