//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/7/4.
//

import Foundation

struct Outlet {
    let property: String
    let id: String
}

/// if node have no id, or Xib have no instance yet, return false by default
func hasOutlet(node: XibNode) throws -> Bool {
    guard let id = node.attrs["id"] else{
        throw XibConverterError.missingAttribute("id")
    }
    guard let instance = Xib.instance else {
        throw XibConverterError.missingXibInstance
    }
    return instance.outlets.map {$0.id}.contains(id)
}

class Xib {
    public static var instance: Xib?
    
    private var baseNode: XibNode
    public var outlets: [Outlet] = []
    
    public var actions: [Action] = []
    public var baseView: XibNode?
    public var constraints = [XibNode]()
    public var subviews: [XibNode] = []
    /// dictionionary of id to name
    public var idDict: [String: String] = [:]
    
    public init(xibData: Data) {
        let parser = XMLParser(data: xibData)
        let delegate = MyParserDelegate()
        parser.delegate = delegate
        parser.parse()
        baseNode = delegate.baseNode!
        // outlet must executable before navigation to construct idDict
        getOutletsAndActions(node: baseNode)
        navigateGettingInterestPoints(from: baseNode)
        defer {
            // assign baseView's name to self, run last to avoid override by other code.
            if let baseView {
                if let id = baseView.attrs["id"] {
                    idDict[id] = "self"
                }
            }
        }
        Xib.instance = self
    }
    
    // recursively get the outlet
    private func getOutletsAndActions(node: XibNode) {
        if node.tag == "outlet" {
            self.outlets.append(
                Outlet(
                    property: node.attrs["property"]!,
                    id: node.attrs["destination"]!
                )
            )
        }
        
        if node.tag == "action" {
            self.actions.append(
                Action(name: node.attrs["selector"]!.replacingOccurrences(of: ":", with: ""))
            )
        }
        
        for childNode in node.content {
            getOutletsAndActions(node: childNode)
        }
    }
    
    
    private func navigateGettingInterestPoints(from node: XibNode) {
        // without exception, name is set to tag + "__" + modifiedID
        if let id = node.attrs["id"] {
            idDict[id] = node.tag + "__" + id.replacingOccurrences(of: "-", with: "_")
        }
        
        switch node.tag {
        case "constraints":
            self.constraints.append(node)
        case "subviews":
            if self.subviews.isEmpty {
                resolveBaseView(node: node)
            }
            self.subviews.append(node)
            // case "viewLayoutGuide":
            // self.idDict[node.attrs["id"]!] = "view.safeAreaLayoutGuide"
        default:
            break
        }
        
        // override name if it has an outlet
        for outlet in self.outlets {
            if outlet.id == node.attrs["id"] {
                self.idDict[node.attrs["id"]!] = outlet.property
            }
        }
        
        for childNode in node.content {
            navigateGettingInterestPoints(from: childNode)
        }
    }
    
    private func resolveBaseView(node: XibNode) {
        guard let father = node.father else { return }
        
        baseView = father
        
//        if father.attrs["id"] == nil {
//            baseView = father.father
//            father.attrs["id"] = father.father?.attrs["id"] ?? "baseView"
//        }
//        if let key = father.attrs["key"] {
//            idDict[father.attrs["id"]!] = key
//        }
    }
}

func getName(with id: String) -> String {
    return Xib.instance!.idDict[id]!
}
