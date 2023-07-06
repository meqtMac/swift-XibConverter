//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/7/6.
//

import Foundation

/// Serialize Xib Documents
enum XibUINode: String {
    // UIElement
    case view
    case textView
    case button
    
    // properity
    case color
    
    // Constraint
    case constraint
    
    // Connections
    case action
    case outlet
    
    // View Hierachy
    case subview
    
    func getElement(with attributes: [String: String] ) throws -> any XibElement {
        switch self {
        case .view:
            return try XibView(attributes: attributes)
        case .textView:
            return try XibTextView(attributes: attributes)
        case .button:
            return try XibButton(attributes: attributes)
        case .color:
            return try XibColor(attributes: attributes)
        case .constraint:
            return try XibConstraint(attributes: attributes)
        case .action:
            return try XibAction(attributes: attributes)
        case .outlet:
            return try XibOutlet(attributes: attributes)
        case .subview:
            return try XibSubView(attributes: attributes)
        }
    }
}

