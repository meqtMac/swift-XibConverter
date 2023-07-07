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
    
    let uiDeclarationGenerator = UIDeclarationsGenerator()
    
    let uiDeclarations = uiDeclarationGenerator.generateUIDeclarations(subviews: xib.subviews)
    let constraintsDeclarations = ConstraintsGenerator().generateConstraintsDeclarations(nodes: xib.constraints)
    
    // view hierachy
    var viewHierachy = ""
    for subview in xib.subviews {
        viewHierachy += ViewHierarchy.generateViewHierarchy(subview: subview)
    }
    
    // base view
    let baseViewDeclaration = uiDeclarationGenerator.generateBaseViewProperties(baseView: xib.baseView)
    
    // actions
    let actionaDeclarations = ActionGenerator.generate(with: xib.actions)
    
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
    
        // MARK: Actions
        \(actionaDeclarations)
    
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
    if #available(iOS 17, *) {
        #Preview {
            \( (className ?? "<#CustomView#>") + "()")
        }
    } else {
        // Fallback on earlier versions
    }
    """
}
