//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/5.
//

import Foundation

/// The document structure parser, no more work than assign tag, attributes, content tree and father. Assume no expection happens. Return the single baseNode for the xib document.
class MyParserDelegate: NSObject, XMLParserDelegate {
    var baseNode: XibNode?
    var xibNodeStack: [XibNode] = []
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String]) {
        let node = XibNode(tag: elementName, attrs: attributeDict, content: [], father: xibNodeStack.last)
        if baseNode == nil {
            baseNode = node
        }else{
            xibNodeStack.last!.content.append(node)
        }
        xibNodeStack.append(node)
    }
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        let _ = xibNodeStack.removeLast()
    }
}

