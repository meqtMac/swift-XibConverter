//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/5.
//

import Foundation

class XibNode {
    let tag: String
    
    var attrs: [String: String]
    
    var content: [XibNode]
    
    /// assigned in parse delegate
    var father: XibNode?
    
    // used with parse delegate
    init(tag: String, attrs: [String : String], content: [XibNode] = [], father: XibNode? = nil) {
        self.tag = tag
        self.attrs = attrs
        self.content = content
        self.father = father
    }
}

enum XibUINode: String {
    case view = "view"
    case textView = "textView"
    case outlet = "outlet"
    case constraint = ""
    case color
    case button
    case action
    
    case subview
    
    struct XibSubView {
        let parentID: String
        var childrenID: [String]
    }
    struct XibView {}
    struct XibTextView {}
    struct XibButton {}
    struct XibLabel {}
    
    struct XibOutlet {}
    struct XibAction {}
    struct XibConstraint {}
    struct XibColor {}
}


/**
 XibUIStruct
 a node with a tag and some attributes,
 ```xml
 <button
    opaque="NO"
    contentMode="scaleToFill"
    contentHorizontalAlignment="center"
    contentVerticalAlignment="center"
    buttonType="system"
    lineBreakMode="middleTruncation"
    translatesAutoresizingMaskIntoConstraints="NO"
    id="cUU-l9-3Uj"
    >
 ```
 ```swift
 let button = UIButton()
 button.isopaque = true
 button.contentMode = .scaleToFill
 ```
 it have attributes and attributes have value to be assigned.
 
 property as content inside with has a key and property type
 ```xml
 <color key="backgroundColor" systemColor="systemPinkColor"/>
 <fontDescription key="fontDescription" type="system" pointSize="40"/>
 ```
 
 ### subview, with acts as bridge for view hirechery
 
 ### views there must be one root view.
 */
