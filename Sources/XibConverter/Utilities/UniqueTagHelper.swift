//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/6.
//

import Foundation

public typealias AttributeDict = [String: Set<String>]
public typealias TagAttributeDict = [String: AttributeDict]

public func mergeAttributeDicts(
    _ dict1: inout AttributeDict,
    _ dict2: AttributeDict
) {
    for (key, set2) in dict2 {
        if let set1 = dict1[key] {
            let mergedSet = set1.union(set2)
            dict1[key] = mergedSet
        } else {
            dict1[key] = set2
        }
    }
}

public func mergeAttributeDicts(
    _ dict1: inout AttributeDict,
    _ dict2: [String: String]
) {
    for (key, set2) in dict2 {
        if let set1 = dict1[key] {
            let mergedSet = set1.union(Set([set2]))
            dict1[key] = mergedSet
        } else {
            dict1[key] = Set([set2])
        }
    }
}

public func mergeTagAttributeDicts(
    _ dict1: inout TagAttributeDict,
    _ dict2: TagAttributeDict
) {
    for (tag, attributeDict2) in dict2 {
        if var attributeDict1 = dict1[tag] {
            mergeAttributeDicts(&attributeDict1, attributeDict2)
            dict1[tag] = attributeDict1
        } else {
            dict1[tag] = attributeDict2
        }
    }
}

final class UniqueTagParserDelegate: NSObject, XMLParserDelegate {
    var tagAttributeDict = TagAttributeDict()
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
//        tagSet.insert(elementName)
//        tagDict[elementName, default: Set<String>()].formUnion()
        mergeAttributeDicts(
            &tagAttributeDict[elementName, default: [String: Set<String>]()],
            attributeDict
        )
    }
}

extension TagAttributeDict {
    public static func generate(with xibData: Data) -> Self {
        let parser = XMLParser(data: xibData)
        let delegate = UniqueTagParserDelegate()
        parser.delegate = delegate
        parser.parse()
       return delegate.tagAttributeDict
    }
}
