////
////  File 2.swift
////  
////
////  Created by 蒋艺 on 2023/7/4.
////
//
//import Foundation
class XibNode {
    let tag: String
    var attrs: [String: String]
    var content: [XibNode]
    var father: XibNode?
    init(tag: String, attrs: [String : String], content: [XibNode] = [], father: XibNode? = nil) {
        self.tag = tag
        self.attrs = attrs
        self.content = content
        self.father = father
    }
}

struct Outlet {
    let property: String
    let id: String
}

typealias IDtoName = [String: String]
typealias AditionalConfiguration = [String: [String: () -> String]]
typealias Rules = [String: [String: String]]

struct Constraint {
    let anchor: String
    let declaration: String
}

typealias Constraints = [String: [Constraint]]


struct UIDeclarationConfig {
    var visiblityModifier: String
    var type: String
    var initializationMethod: String
    var beforeInstanceProperties: String
}
