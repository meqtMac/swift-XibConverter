//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/7/6.
//

import Foundation
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
struct XibSubView: XibElement {
    init(attributes: [String: String]) throws {
        fatalError("Haven't implemented")
    }
    
    let parentID: String
    var childrenID: [String]
}

/// View
struct XibView: XibElement {
    init(attributes: [String: String]) throws {
        // TODO: Implemenation
        fatalError()
    }
}

struct XibTextView: XibElement {
    init(attributes: [String : String]) throws {
        // TODO: Implementation
        fatalError()
    }
}
struct XibButton: XibElement {
    init(attributes: [String : String]) throws {
        // TODO: Implementation
        fatalError()
    }
}
struct XibLabel: XibElement {
    init(attributes: [String : String]) throws {
        // TODO: implemenatation
        fatalError()
    }
}

struct XibOutlet: XibOutletProtocol {
    let property: String
    let destination: String
    let id: String
    
    init(attributes: [String : String]) throws {
        guard let property = attributes["property"],
              let destination = attributes["destination"],
              let id = attributes["id"] else
        {
            throw XibElementInitError.missingAttribute("id in \(attributes)")
        }
        self.property = property
        self.destination = destination
        self.id = id
    }
}

struct XibAction: XibActionProtocol {
    enum EventType: String {
        case touchUpInside
    }
    
    var selector: String
    var destionation: String
    var id: String
    var eventType: EventType
    
    
    init(attributes: [String : String]) throws {
        guard let selector = attributes["selector"],
              let destination = attributes["destination"],
              let eventTypeRaw = attributes["eventType"],
              let id = attributes["id"]
        else {
            throw XibElementInitError.missingAttribute("for \(attributes)")
        }
        
        guard let event =  EventType(rawValue: eventTypeRaw) else {
            throw XibElementInitError.undefinedKey
        }
        
        self.selector = selector
        self.destionation = destination
        self.eventType = event
        self.id = id
    }
}

struct XibConstraint: XibConstraintProtocol {
    
    enum ItemType: Equatable {
        case baseView
        /// case where secondItem is nil
        case escape
        case id(String)
    }
    
    enum ConstraintAttribute: String {
        case left
        case right
        case top
        case bottom
        case leading
        case trailing
        case width
        case height
        case centerX
        case centerY
        case lastBaseline
        case fristBaselin
        case leftMargin
        case rightMargin
        case topMargin
        case bottomMargin
        case leadingMargin
        case trailingMargin
        case centerXWithinMargins
        case centerYWithinMargins
        /// case used when secondItem is nil and secondAttribute should be .notAnAttribute
        case notAnAttribute
    }
    
    var multipler: CGFloat
    var constant: CGFloat
    var id: String
    var firstItem: ItemType
    var secondItem: ItemType
    var firstAttribute: ConstraintAttribute
    var secondAttribute: ConstraintAttribute
    
    init(attributes: [String : String]) throws {
        // assign id
        guard let id = attributes["id"] else {
            throw XibElementInitError.missingAttribute("id")
        }
        self.id = id
        
        // assign first item
        if let firstItemRaw = attributes["firstItem"] {
            self.firstItem = .id(firstItemRaw)
        }else{
            // have no firstItem Attribute, implicitly use baseView
            self.firstItem = .baseView
        }
        
        // assign first Attribute
        guard let firstAttributeRaw = attributes["firstAttribute"] else {
            throw XibElementInitError.missingAttribute("firstAttribute")
        }
        
        if let firstAttribute = ConstraintAttribute(rawValue: firstAttributeRaw) {
            self.firstAttribute = firstAttribute
        }else{
            throw XibConstraintInitError.undefineAttributeKey("firstAttribute:\(firstAttributeRaw)")
        }
        
        // assign second item
        if let secondItemRaw = attributes["secondItem"] {
            self.secondItem = .id(secondItemRaw)
            
            guard let secondAttributeRaw = attributes["secondAttribute"] else {
                throw XibElementInitError.missingAttribute("\(attributes), missing secondAttribute")
            }
            guard let secondAttribute = ConstraintAttribute(rawValue: secondAttributeRaw) else {
                throw XibConstraintInitError.undefineAttributeKey("secondItem: \(secondItemRaw)")
            }
            self.secondAttribute = secondAttribute
        }else {
            // cases where there is no secondItem
            self.secondItem = .escape
            self.secondAttribute = .notAnAttribute
        }
        
        // assign constant
        self.constant = 0
        if let constantString = attributes["constant"] {
            if let doubleVal = Double(constantString) {
                self.constant = CGFloat(doubleVal)
            }else{
                throw XibConstraintInitError.undefineAttributeKey("constant: \(constantString)")
            }
        }
        
        // assign multipler
        self.multipler = 1
        if let multiplierString = attributes["multiplier"] {
            self.multipler = try XibConstraint.multiplerInitHelper(multiplierString)
        }
    }
    
    /**
     Multipler Init Helper functions
     ```swift
     multiplerInitHelper("2:1")
     ```
     get CGFloat 2
     */
    static func multiplerInitHelper(_ rawString: String) throws -> CGFloat {
        let components = rawString.split(separator: ":")
        guard components.count == 2 else {
            throw XibConstraintInitError.undefineAttributeKey("multiplier: \(rawString)")
        }
        guard let first = components.first, let last = components.last, let firstDouble = Double(first), let secondDouble = Double(last) else {
                throw XibConstraintInitError.undefineAttributeKey("multiplier: \(rawString)")
        }
        return CGFloat( firstDouble / secondDouble )
    }
}


struct XibColor: XibElement {
    init(attributes: [String : String]) throws {
        //TODO: implementation
        fatalError()
    }
}
