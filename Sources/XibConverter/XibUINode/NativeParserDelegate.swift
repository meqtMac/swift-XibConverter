//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/7/6.
//

import Foundation
public final class NativeParserDelegate: NSObject, XMLParserDelegate {
    
    var baseViewID: String?
    var views: [any XibViewProtocol] = []
    var subViews: [XibSubView] = []
    var outlets: [XibOutlet] = []
    var actions: [XibAction] = []
    var constraints: [XibConstraint] = []
    
    // subView ID to Indice map.
    private var subViewIDDict: [UUID: Int] = [:]
    
    private var viewIDStack: [String] = []
    private var subViewIDStack: [UUID] = []
    
    private func viewHelper(view: XibViewProtocol) {
        baseViewID = baseViewID ?? view.id
        views.append(view)
        viewIDStack.append(view.id)
        
        if let subViewId = subViewIDStack.last {
            guard let index = subViewIDDict[subViewId] else {
                fatalError("subView lost")
            }
            
            subViews[index].addchildID(id: view.id)
        }
        //MARK: problem of value semantics
        // bug happens here
        // subViewStack[count-1].addchildID(id: view.id)
    }
    
    private func subViewStackHelper(subviewID: UUID) {
//        subViews.append(subviewID)
        subViewIDStack.append(subviewID)
    }
    
    public func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String]) {
        guard let node = XibUINode(rawValue: elementName) else {
            fatalError("Unknown Node \(elementName)")
        }
        
        do {
            switch node {
                // views
            case .view:
//                let view = try XibView(attributes: attributeDict)
//                viewHelper(view: view)
                break
            case .textView:
//                let view = try XibTextView(attributes: attributeDict)
//                viewHelper(view: view)
                break
            case .button:
//                let view = try XibButton(attributes: attributeDict)
//                viewHelper(view: view)
                break
            case .label:
//                let label = try XibLabel(attributes: attributeDict)
//                viewHelper(view: label)
                break
            case .pageControl:
//                let pageControl = try XibPageControl(attributes: attributeDict)
//                viewHelper(view: pageControl)
                // properites
                break
            case .color:
                //                print("color: \(attributeDict)")
                break
            case .autoresizingMask:
                //                print("autoresizingMask: \(attributeDict)")
                break
            case .string:
                //                print("string: \(attributeDict)")
                break
            case .fontDescription:
                break
                //                print("font: \(attributeDict)")
            case .textInputTraits:
                //                print("textInputTraits: \(attributeDict)")
                break
            case .dataDetectorType:
                //                print("dataDetectorType: \(attributeDict)")
                break
            case .customNil:
                //                print("customNil: \(attributeDict)")
                break
            case .state:
                //                print("state: \(attributeDict)")
                break
            case .freeformSimulatedSizeMetrics:
                break
                
            case .userDefinedRuntimeAttributes:
                print("\(elementName): \(attributeDict)")
                
                
            case .constraint:
                let constraint = try XibConstraint(attributes: attributeDict)
                constraints.append(constraint)
                
            case .action:
                let action = try XibAction(attributes: attributeDict)
                actions.append(action)
            case .outlet:
                let outlet = try XibOutlet(attributes: attributeDict)
                outlets.append(outlet)
                
            case .subview:
                if let parentViewID = viewIDStack.last {
                    let subView = XibSubView(parentID: parentViewID)
                    subViews.append(subView)
                    subViewStackHelper(subviewID: subView.id)
                    subViewIDDict[subView.id] = subViews.count - 1
                }
            default:
                print("ignore node: \(elementName) \(attributeDict)")
            }
        }catch {
            print(error)
        }
    }
    
    public func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        guard let node = XibUINode(rawValue: elementName) else {
            fatalError("Unknown Node \(elementName)")
        }
        switch node {
        case .view, .textView, .button, .label:
            let _ = viewIDStack.popLast()
        case .subview:
            let _ = subViewIDStack.popLast()
        default:
            return
        }
    }
}
