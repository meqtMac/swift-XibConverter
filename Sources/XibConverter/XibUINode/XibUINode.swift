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
    case imageView
    case textView
    case button
    case label
    case pageControl
    
    /**
     properity parsing are context base, that they are assigned to a view
     */
    case color
    case autoresizingMask
    case string
    case fontDescription
    case textInputTraits
    case dataDetectorType
    case customNil = "nil"
    case state
    case freeformSimulatedSizeMetrics
    
    case userDefinedRuntimeAttributes
    case userDefinedRuntimeAttribute
    
    case real

    
    // Constraint
    case constraint
    
    // Connections
    case action
    case outlet
    
    // View Hierachy
    case subview = "subviews"
    
    /// cases to ignore
    /// - point: `<point key="canvasLocation" x="90.5" y="128.5"/>`
    case point
    /// - rect: `<rect key="frame" x="0.0" y="0.0" width="320" height="568"/>`
    case rect
    /// - constraints: `<constraints>`
    case constraints
    /// - <connections>
    case connections
    /// - <document>
    case document
    case device
    case adaption
    case dependencies
    case deployment
    case plugIn
    case capability
    case objects
    case placeholder
    case resources // ignored
    case image
    case inset // TODO: unmanaged
    case viewLayoutGuide // TODO: unmanaged
    case systemColor // ignored
    case adaptation // ignored
}
