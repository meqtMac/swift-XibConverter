//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/7/5.
//

import Foundation
/// convert xibData to a custom Swift class in UIKit
public func xib2Swift(
    xibData: Data,
    className: String? = nil,
    superclass: String? = nil
) -> String {
    let xib = Xib(xibData: xibData)
    
    let uiDeclarationGen = UIDeclarationsGen()
    
    let uiDeclarations = uiDeclarationGen.generateUIDeclarations(subviews: xib.subviews)
    let constraintsDeclarations = ConstraintsGenerator().generateConstraintsDeclarations(nodes: xib.constraints)
    
    var viewHierachy = ""
    for subview in xib.subviews {
        viewHierachy += ViewHierarchy.generateViewHierarchy(subview: subview)
    }
    
    let baseViewDeclaration = uiDeclarationGen.generateBaseViewProperties(baseView: xib.baseView)
    
    return """
    import UIKit
    
    class \(className ?? "<#CustomView#>"):\(superclass ?? "<#superClass#>" ){
        public override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
    
        required init?(coder: NSCoder) {
            fatalError("\\(#file), \\(#line)")
        }
    
        // MARK: UI Elements
        \(uiDeclarations)
        // MARK: Setup UI
        private func setupUI() {
            // base view Properties
            \(baseViewDeclaration.replacingOccurrences(of: "\t", with: ""))
    
            // Hierachy
            \(viewHierachy)
    
            // Constraints
            \(constraintsDeclarations)
        }
    }
    
    #Preview {
        \( (className ?? "<#CustomView#>") + "()")
    }
    """
}
