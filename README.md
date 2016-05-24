# XMLConvertor
A Simple Swift program that imports a XML file from an URL and applies rules on a XML object to create a new XML object and displays it in the app.

Currently there is only one rule:
Remove string from XML.
- if element name = string: element removed
- if attribute name or value = string: attribute removed
- if element text content contains the string, the string is removed from the content

Developped using TDD. 
XMLParser and the ViewController do not have tests yet.

Not finished yet
