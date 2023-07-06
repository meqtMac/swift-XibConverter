//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/6.
//

import Foundation

public struct NativeXib {
    
    var baseViewID: String
    var views: [any XibViewProtocol] = []
    var subViews: [XibSubView] = []
    var outlets: [XibOutlet] = []
    var actions: [XibAction] = []
    var constraints: [XibConstraint] = []
 
    public init(xibData: Data) {
        let parser = XMLParser(data: xibData)
        let delegate = NativeParserDelegate()
        parser.delegate = delegate
        parser.parse()
        guard let baseViewID = delegate.baseViewID else {
            fatalError("xib file have no base View id")
        }
        self.baseViewID = baseViewID
        self.views = delegate.views
        self.subViews = delegate.subViews
        self.outlets = delegate.outlets
        self.actions = delegate.actions
        self.constraints = delegate.constraints
   }
    
}
