//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/7/4.
//

import Foundation



class ConstraintsGenerator {
    
    /**
     Generate constraint string
     ```swift
     print(
     NSLayoutConstraintString(
     item: "arrowImageView",
     attribute: ".leading",
     relatedBy: ".equal",
     toItem: "tipLabel",
     attribute: ".trailing",
     multiplier: "1",
     constant: "4"
     )
     )
     // NSLayoutConstraint(
     //    item: arrowImageView,
     //    attribute: .leading,
     //   relatedBy: .equal,
     //   toItem: tipLabel,
     //    attribute: .trailing,
     //    multiplier: 1,
     //    constant: 4
     //)
     */
    public func NSLayoutConstraintString(
        item: String,
        firstAttribute: String,
        relatedBy: String,
        toItem: String,
        secondAttribute: String,
        multipiler: String,
        constant: String,
        format: Formatter = .list
    ) -> String {
        switch format {
        case .list:
                """
                NSLayoutConstraint(
                    item: \(item),
                    attribute: \(firstAttribute),
                    relatedBy: \(relatedBy),
                    toItem: \(toItem),
                    attribute: \(secondAttribute),
                    multiplier: \(multipiler),
                    constant: \(constant)
                )
                """
        case .compact:
            """
            NSLayoutConstraint(item: \(item), attribute: \(firstAttribute), relatedBy: \(relatedBy), toItem: \(toItem), attribute: \(secondAttribute), multiplier: \(multipiler), constant: \(constant) )
            """
        }
    }
    
    public enum Formatter {
        /**
         ```swift
         """
         NSLayoutConstraint(
             item: \(item),
             attribute: \(firstAttribute),
             relatedBy: \(relatedBy),
             toItem: \(toItem),
             attribute: \(secondAttribute),
             multiplier: \(multipiler),
             constant: \(constant)
         )
         """
         ```
         */
        case list
        /**
         ```swift
         """
         NSLayoutConstraint(item: \(item), attribute: \(firstAttribute), relatedBy: \(relatedBy), toItem: \(toItem), attribute: \(secondAttribute), multiplier: \(multipiler), constant: \(constant) )
         """
         ```
         */
        case compact
    }
    
    public struct Paramater {
        var multiplier: String?
        var constant: String?
    }
    
    private var constraints = Constraints()
    
    func generateConstraintsDeclarations(nodes: [XibNode]) -> String {
        for constraint in nodes {
            resolveConstraintsDeclarations(constraint.content)
        }
        return "NSLayoutConstraint.activate([\(organizeConstraintsDeclarations())])\n"
    }
    
    private func resolveConstraintsDeclarations(_ nodes: [XibNode]) {
        for node in nodes {
            guard let grandFather = node.father?.father else {
                print("\nerror\n")
                continue
            }
            
//            var parameters = ""
//            if let constant = node.attrs["constant"] {
//                parameters += ", constant: \(constant)"
//            }
//            if let multiplier = node.attrs["multiplier"] {
//                parameters += ", multiplier: \(multiplier.replacingOccurrences(of: ":", with: "/"))"
//            }
            let parameter = Paramater(
                multiplier: node.attrs["multiplier"]?.replacingOccurrences(of: ":", with: "/"),
                constant: node.attrs["constant"]
            )
            
            if (node.attrs["firstAttribute"] == "width" || node.attrs["firstAttribute"] == "height") && node.attrs["secondItem"] == nil {
                generateConstraintWithConstant(
                    element: resolveIDtoPropertyName(id: grandFather.attrs["id"]!),
                    anchor: node.attrs["firstAttribute"]!,
                    constant: node.attrs["constant"]
                )
            } else if node.attrs["firstItem"] == nil {
                generateConstraint(
                    element: resolveIDtoPropertyName(id: grandFather.attrs["id"]!),
                    anchor: node.attrs["firstAttribute"]!,
                    secondElement: resolveIDtoPropertyName(id: node.attrs["secondItem"]!),
                    secondAnchor: node.attrs["secondAttribute"]!.replacingOccurrences(of: "Margin", with: ""),
                    parameter: parameter
                )
            } else {
                generateConstraint(
                    element: resolveIDtoPropertyName(id: node.attrs["firstItem"]!),
                    anchor: node.attrs["firstAttribute"]!,
                    secondElement: resolveIDtoPropertyName(id:node.attrs["secondItem"]!),
                    secondAnchor: node.attrs["secondAttribute"]!.replacingOccurrences(of: "Margin", with: ""),
                    parameter: parameter
                )
            }
        }
    }
    
    private func generateConstraint(
        element: String,
        anchor: String,
        secondElement: String,
        secondAnchor: String,
        parameter: Paramater
    ) {
        if anchor == "bottom" || anchor == "trailing" {
            let declaration = NSLayoutConstraintString(
                item: secondElement,
                firstAttribute: ".\(secondAnchor)",
                relatedBy: ".equal",
                toItem: element,
                secondAttribute: ".\(anchor)",
                multipiler: parameter.multiplier ?? "1",
                constant: parameter.constant == nil ? "0" : "-" + parameter.constant!
            )
            
            //            pushConstraint(
            //                secondElement,
            //                constraint: Constraint(
            //                    anchor: secondAnchor,
            //                    declaration: "\t\(secondElement).\(secondAnchor)Anchor.constraint(equalTo: \(element).\(anchor)Anchor\(parameters.replacingOccurrences(of: "constant: ", with: "constant: -"))),\n"
            //                )
            //            )
            pushConstraint(
                secondElement,
                constraint: Constraint(
                    anchor: secondAnchor,
                    declaration: declaration + ",\n"
                )
            )
            
        }else {
            let declaration = NSLayoutConstraintString(
                item: element,
                firstAttribute: ".\(anchor)",
                relatedBy: ".equal",
                toItem: secondElement,
                secondAttribute: ".\(secondAnchor)",
                multipiler: parameter.multiplier ?? "1",
                constant: parameter.constant ?? "0"
            )

            pushConstraint(
                element,
                constraint: Constraint(
                    anchor: anchor,
                    declaration: declaration + ",\n"
                )
            )
        }
    }
    
    private func generateConstraintWithConstant(element: String, anchor: String, constant: String?) {
        if let constant = constant {
            let declaration = NSLayoutConstraintString(
                item: element,
                firstAttribute: ".\(anchor)",
                relatedBy: ".equal",
                toItem: "nil",
                secondAttribute: ".notAnAttribute",
                multipiler: "1",
                constant: constant
            )
            // MARK: update with list version constraint output
            //            pushConstraint(
            //                element,
            //                // replace with new list version
            //                constraint: Constraint(
            //                    anchor: anchor,
            //                    declaration: "\t\(element).\(anchor)Anchor.constraint(equalToConstant: \(constant)),\n"
            //                )
            //            )
            pushConstraint(
                element,
                constraint: Constraint(
                    anchor: anchor,
                    declaration: declaration + ",\n"
                )
            )
        }
    }
    
    private func pushConstraint(_ element: String, constraint: Constraint) {
        constraints[element, default: []].append(constraint)
    }
    
    private func organizeConstraintsDeclarations() -> String {
        var declarations = "\n"
        for ( _ , value) in constraints {
            let constraints = orderWithAnchor(value)
            for constraint in constraints {
                declarations += constraint.declaration
            }
            declarations += "\n"
        }
        return declarations
    }
    
    private func orderWithAnchor(_ constraints: [Constraint]) -> [Constraint] {
        let order = ["top", "bottom", "leading", "trailing", "centerX", "centerY", "width", "height"]
        var orderedConstraints: [Constraint] = []
        for anchor in order {
            for constraint in constraints {
                if constraint.anchor == anchor {
                    orderedConstraints.append(constraint)
                }
            }
        }
        return orderedConstraints
    }
}
