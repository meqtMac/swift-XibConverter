//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/7/4.
//

import Foundation

class Xib {
    public static var instance: Xib?
    
    private var baseNode: XibNode
    private var outlets: [Outlet] = []
    
    public var baseView: XibNode?
    public var constraints = [XibNode]()
    public var subviews: [XibNode] = []
    public var tableIDtoName: IDtoName = [:]
    
    public init(xibData: Data) {
        let parser = XMLParser(data: xibData)
        let delegate = MyParserDelegate()
        parser.delegate = delegate
        parser.parse()
        baseNode = delegate.baseNode!
        getOutlets(node: baseNode)
        navigateGettingInterestPoints(from: baseNode)
        Xib.instance = self
    }
    
    // recursively get the outlet
    private func getOutlets(node: XibNode) {
        if node.tag == "outlet" {
            self.outlets.append(Outlet(property: node.attrs["property"]!, id: node.attrs["destination"]!))
        }
        
        for childNode in node.content {
            getOutlets(node: childNode)
        }
    }
    
    
    private func navigateGettingInterestPoints(from node: XibNode) {
//        self.tableIDtoName[node.attrs["id"]!] = "\(node.tag)__\(node.attrs["id"]!.replacingOccurrences(of: "-", with: "_"))"
        if let id = node.attrs["id"] {
            let modifiedID = id.replacingOccurrences(of: "-", with: "_")
            tableIDtoName[id] = node.tag + "__" + modifiedID
        }
        
        switch node.tag {
        case "constraints":
            self.constraints.append(node)
        case "subviews":
            if self.subviews.isEmpty {
                resolveBaseView(node: node)
            }
            self.subviews.append(node)
        case "viewLayoutGuide":
            self.tableIDtoName[node.attrs["id"]!] = "view.safeAreaLayoutGuide"
        default:
            break
        }
        
        for outlet in self.outlets {
            if outlet.id == node.attrs["id"] {
                self.tableIDtoName[node.attrs["id"]!] = outlet.property
            }
        }
        
        for childNode in node.content {
            navigateGettingInterestPoints(from: childNode)
        }
    }
    
    private func resolveBaseView(node: XibNode) {
        guard let father = node.father else { return }
        
        baseView = father
        if father.attrs["id"] == nil {
            baseView = father.father
            father.attrs["id"] = father.father?.attrs["id"] ?? "baseView"
        }
        if let key = father.attrs["key"] {
            tableIDtoName[father.attrs["id"]!] = key
        }
    }
}

func resolveIDtoPropertyName(id: String) -> String {
    return Xib.instance!.tableIDtoName[id]!
}
