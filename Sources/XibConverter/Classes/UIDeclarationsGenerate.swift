//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/7/4.
//

import Foundation
let ignoredTags: [String] = []

// default Rules was omitted for simplicity
let defaultRules: [String: String] = [
    "opaque": "isOpaque = false",
    "userInteractionEnabled": "isUserInteractionEnabled = false",
    "customClass": "customClass = "
]

/// determine if a key for a `XibNode` with tag  should be ignore
//func shouldIgnoreProperty(tag: String, key: String) -> Bool {
//    let propertyToIgnore: [String: [String]] = [
//        "label": ["minimumFontSize"],
//        "button": ["buttonType", "lineBreakMode"],
//        "imageView": ["catalog"],
//        "tableView": ["style"],
//        "collectionView": ["dataMode"],
//        "common": [
//            "horizontalHuggingPriority",
//            "verticalHuggingPriority",
//            "fixedFrame", "id",
//            "adjustsLetterSpacingToFitWidth"
//        ]
//    ]
//
//    let ignoredRules = propertyToIgnore["common", default: []] + propertyToIgnore[tag, default: []]
//    return ignoredRules.contains(key)
//}

//typealias Rules = [String: [String: String]]

// MARK: Property for tags
let propertyIgnoreDict: [String: [String]] = [
    "label": ["minimumFontSize"],
    "button": ["buttonType", "lineBreakMode"],
    "imageView": ["catalog"],
    "tableView": ["style"],
    "collectionView": ["dataMode"],
    "common": [
        "horizontalHuggingPriority",
        "verticalHuggingPriority",
        "fixedFrame", "id",
        "adjustsLetterSpacingToFitWidth"
    ]
]

/// determine whether a property should be ignored from property ignore Dict
func ignoreProperty(tag: String, key: String) -> Bool {
    var ignoreList: [String] = []
    if let list = propertyIgnoreDict[tag] {
        ignoreList.append(contentsOf: list)
    }
    if let list = propertyIgnoreDict["common"] {
        ignoreList.append(contentsOf: list)
    }
    
    return ignoreList.contains(key)
}



struct UIDeclarationConfig {
    var visiblityModifier: String
    var type: String
    var initializationMethod: String
    var beforeInstanceProperties: String
}

class UIDeclarationsGenerator {
    
    private var declationConfig = UIDeclarationConfig(
        visiblityModifier: "private ",
        type: "UI",
        initializationMethod: "()",
        beforeInstanceProperties: ""
    )
    
    private func setupDeclarationConfig(node: XibNode ) -> UIDeclarationConfig {
        return UIDeclarationConfig(
            visiblityModifier: ( (try? hasOutlet(node: node)) ) ?? false ? "public " : "private ",
            type: "UI\((node.tag).capitalizeFirstLetter())",
            initializationMethod: "()",
            beforeInstanceProperties: ""
        )
    }
    
    func generateUIDeclarations(subviews: [XibNode]) -> String {
        var uiDeclarations = ""
        for subview in subviews {
            uiDeclarations += resolveUIDeclaration(subview.content)
        }
        return uiDeclarations
    }
    
    private func resolveUIDeclaration(_ nodes: [XibNode]) -> String {
        var uiDeclarations = ""
        let nodes = nodes.filter { !ignoredTags.contains($0.tag) }
        
        for node in nodes {
            declationConfig = setupDeclarationConfig(node: node)
            //            let  declationConfig = setupDeclarationConfig(node: node)
            
            var properties = resolveAttributes(node)
            properties += "\(generateDeclarationForSubNodes(tag: node.tag, nodes: node.content))"
            
            uiDeclarations += """
            \n\(declationConfig.visiblityModifier)lazy var \(getName(with: node.attrs["id"]!)): \(declationConfig.type) = {
                \(declationConfig.beforeInstanceProperties)\tlet \(node.tag) = \(declationConfig.type)\(declationConfig.initializationMethod)\(properties)
                \treturn \(node.tag)
            }()\n
            """
        }
        return uiDeclarations
    }
    
    private func resolveAttributes(_ node: XibNode) -> String {
        let attributes = node.attrs
        var property = "\n"
        for (key, value) in attributes {
            //            if shouldIgnoreProperty(tag: node.tag, key: key) {
            //                continue
            //            }
            if ignoreProperty(tag: node.tag, key: key) { continue }
            
            let attributeDeclaration = "\t\(node.tag).\(UIDeclarationsGenerator.uikitPropertyName(node.tag, key)) = \(resolveResultValue(value, property: key, node: node))\n"
            if let attr = defaultRules[key] {
                if attributeDeclaration == "\t\(node.tag).\(attr)\n" {
                    continue
                }
            }
            property += attributeDeclaration
        }
        return property
    }
    
    static let propertyReNameDict: [String: [String: String] ] = [
        "label": [
            "adjustsFontSizeToFit": "adjustsFontSizeToFitWidth"
        ],
        "slider": [
            "minValue": "minimumValue",
            "maxValue": "maximumValue",
        ],
        "tableView" : [
            "multipleTouchEnabled": "isMultipleTouchEnabled",
            "clipsSubviews": "clipsToBounds",
        ],
        "collectionView": [
            "multipleTouchEnabled": "isMultipleTouchEnabled",
            "directionalLockEnabled": "isDirectionalLockEnabled",
            "pagingEnabled": "isPagingEnabled",
            "prefetchingEnabled": "isPrefetchingEnabled",
        ],
        "common": [
            "clipsSubviews": "clipsToBounds",
            "opaque": "isOpaque",
            "userInteractionEnabled": "isUserInteractionEnabled",
            "scrollEnabled" : "isScrollEnabled",
            "multipleTouchEnabled": "isMultipleTouchEnabled"
        ]
    ]
    
    /**
     rename property name if needed
     ```xml
     <textView
     clipsSubviews="YES"
     multipleTouchEnabled="YES"
     userInteractionEnabled="NO"
     contentMode="scaleToFill"
     textAlignment="natural"
     translatesAutoresizingMaskIntoConstraints="NO"
     id="1hh-mT-vxi">
     ```
     */
    static func uikitPropertyName(_ tag: String, _ key: String) -> String {
        //        if propertyNameDict[tag] == nil {
        //            return propertyNameDict["common"]?[key] ?? key
        //        }
        //        return propertyNameDict[tag]?[key] ?? propertyNameDict["common"]?[key] ?? key
        if let tagSpecificReNameDict = propertyReNameDict[tag] {
            if let newName = tagSpecificReNameDict[key] {
                return newName
            }
        }
        if let commonReNameDict = propertyReNameDict["common"] {
            if let newName = commonReNameDict[key] {
                return newName
            }
        }
        return key
    }
    
    func resolveResultValue(_ result: String, property: String, node: XibNode? = nil) -> String {
        let propertyToResolve: [String: () -> String] = [
            "text": { return "\"\(result)\"" },
            "image": { return node != nil ? "\(Resolve.image(node: node!)!)" : "" },
            "customClass": {
                self.declationConfig.type = result
                return ""
            },
            "lineBreakMode": {
                let lineBreakModes: [String: String] = [
                    "wordWrap": ".byWordWrapping",
                    "tailTruncation": ".byTruncatingTail",
                    "headTruncation": ".byTruncatingHead",
                    "middleTruncation": ".byTruncatingMiddle",
                    "charWrap": ".byCharWrapping",
                    "clip": ".byClipping"
                ]
                return lineBreakModes[result] ?? ".byWordWrapping"
            },
            "placeholder": { return "\"\(result)\"" },
            "default": {
                switch result {
                case "NO":
                    return "false"
                case "YES":
                    return "true"
                default:
                    return result.range(of: #"^\d+$"#, options: .regularExpression) != nil ? result : ".\(result.lowerFirstLetter())"
                }
            }
        ]
        return propertyToResolve[property]?() ?? propertyToResolve["default"]?() ?? ""
    }
    
    func generateDeclarationForSubNodes(tag: String, nodes: [XibNode]) -> String {
        var property = ""
        for node in nodes {
            property += resolveSubNode(tag, node)
        }
        return property
    }
    
    private func resolveSubNode(_ tag: String, _ node: XibNode) -> String {
        let addAdditionalConfiguration: [String: [String: () -> String]] = [
            "button": [
                "state": {
                    var property = ""
                    if let title = node.attrs["title"] {
                        property += "\t\(tag).setTitle(\"\(title)\", for: .\(node.attrs["key"]!))\n"
                    }
                    if  node.attrs["image"] != nil {
                        property += "\t\(tag).setImage(\(Resolve.image(node: node)!), for: .\(node.attrs["key"]!))\n"
                    }
                    if node.attrs["backgroundImage"] != nil {
                        property += "\t\(tag).setBackgroundImage(\(Resolve.image(node: node)!), for: .\(node.attrs["key"]!))\n"
                    }
                    for child in node.content {
                        if child.tag == "color" {
                            property += "\t\(tag).set\((child.attrs["key"]!).capitalizeFirstLetter())(\(Resolve.color(node: child)), for: .\(node.attrs["key"]!))\n"
                        } else if child.tag == "imageReference" {
                            property += "\t\(tag).setImage(\(Resolve.image(node: child)!), for: .\(node.attrs["key"]!))\n"
                        }
                    }
                    return property
                },
                "fontDescription": {
                    let weight = node.attrs["weight"] != nil ? ", weight: .\(node.attrs["weight"]!)" : ""
                    return "\t\(tag).titleLabel?.font = .systemFont(ofSize: \(node.attrs["pointSize"]!)\(weight))\n"
                },
                "buttonConfiguration": {
                    var property = "\t\(tag).configuration = .\(node.attrs["style"]!)()\n"
                    if let title = node.attrs["title"] {
                        property += "\t\(tag).setTitle(\"\(title)\", for: .normal)\n"
                    }
                    for child in node.content {
                        if child.tag == "color" {
                            property += "\t\(tag).configuration?.\(child.attrs["key"]!) = \(Resolve.color(node: child))\n"
                        }
                    }
                    return property
                }
            ],
            "collectionView": [
                "collectionViewFlowLayout": {
                    var property = "\tlet layout = UICollectionViewFlowLayout()\n"
                    let ignoredAttributes = ["id", "key"]
                    for (key, value) in node.attrs {
                        if ignoredAttributes.contains(key) {
                            continue
                        }
                        property += "\tlayout.\(key) = \(self.resolveResultValue(value, property: key))\n"
                    }
                    for child in node.content {
                        if child.tag == "size" {
                            property += "\tlayout.\(child.attrs["key"]!) = CGSize(width: \(child.attrs["width"]!), height: \(child.attrs["height"]!))\n"
                        }
                    }
                    self.declationConfig.beforeInstanceProperties = property
                    self.declationConfig.initializationMethod = "(frame: .zero, collectionViewLayout: layout)"
                    return ""
                }
            ],
            "textField": [
                "textInputTraits": {
                    var property = ""
                    if let keyboardType = node.attrs["keyboardType"] {
                        property += "\t\(tag).keyboardType = .\(keyboardType)\n"
                    }
                    return property
                }
            ],
            "common": [
                "color": {
                    return "\t\(tag).\(node.attrs["key"]!) = \(Resolve.color(node: node))\n"
                },
                "fontDescription": {
                    let weight = node.attrs["weight"] != nil ? ", weight: .\(node.attrs["weight"]!)" : ""
                    return "\t\(tag).font = .systemFont(ofSize: \(node.attrs["pointSize"]!)\(weight))\n"
                },
                "connections": {
                    var property = ""
                    for child in node.content {
                        if child.tag == "action" {
                            property += "\t\(tag).addTarget(self, action: #selector(\(child.attrs["selector"]!.replacingOccurrences(of: ":", with: ""))), for: .\(child.attrs["eventType"]!))\n"
                        }
                    }
                    return property
                },
                "userDefinedRuntimeAttributes": {
                    var property = ""
                    for child in node.content where child.tag == "userDefinedRuntimeAttribute" {
                        if let type = child.attrs["type"] {
                            if type == "number" {
                                if let number = child.content.first {
                                    property += "\t\(tag).\(child.attrs["keyPath"]!) = \(number.attrs["value"]!)\n"
                                }
                            } else if type == "size" {
                                if let size = child.content.first {
                                    property += "\t\(tag).\(child.attrs["keyPath"]!) = CGSize(width: \(size.attrs["width"]!), height: \(size.attrs["height"]!))\n"
                                }
                            } else if type == "color" {
                                if let color = child.content.first {
                                    property += "\t\(tag).\(child.attrs["keyPath"]!) = \(Resolve.color(node: color))\n"
                                }
                            }
                        }
                    }
                    return property
                }
            ]
        ]
        
        if let nodeConfigurations = addAdditionalConfiguration[tag], let nodeConfiguration = nodeConfigurations[node.tag] {
            return nodeConfiguration()
        } else if let commonConfigurations = addAdditionalConfiguration["common"], let commonConfiguration = commonConfigurations[node.tag] {
            return commonConfiguration()
        } else {
            return ""
        }
    }
    
    func generateBaseViewProperties(baseView: XibNode?) -> String {
        var property = ""
        if let baseView = baseView {
            for node in baseView.content {
                property += resolveSubNode(getName(with: baseView.attrs["id"]!), node)
            }
        }
        return property
    }
}


