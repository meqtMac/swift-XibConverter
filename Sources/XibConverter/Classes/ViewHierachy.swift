//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/7/4.
//

import Foundation

class ViewHierarchy {
    static func generateViewHierarchy(subview: XibNode) -> String {
        var hierarchyDeclaration = ""
        guard let fatherId = subview.father?.attrs["id"] else { return hierarchyDeclaration }
        let addMethod = subview.father?.tag == "stackView" ? "addArrangedSubview" : "addSubview"
        
        for node in subview.content {
            if !ignoredTags.contains(node.tag) {
                let fatherPropertyName = getName(with: fatherId)
//                resolveIdToPropertyName(id: fatherId)
                let nodePropertyName = getName(with: node.attrs["id"] ?? "" )
//                resolveIdToPropertyName(id: node.attrs["id"] ?? "")
                hierarchyDeclaration += "\(fatherPropertyName).\(addMethod)(\(nodePropertyName))\n"
            }
        }
        
        return hierarchyDeclaration
    }
}
