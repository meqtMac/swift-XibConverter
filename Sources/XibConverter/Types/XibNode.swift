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

