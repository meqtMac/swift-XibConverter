//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/7/8.
//

//let data = [
//    "view": ["horizontalCompressionResistancePriority", "hidden", "customClass", "verifyAmbiguity", "translatesAutoresizingMaskIntoConstraints", "insetsLayoutMarginsFromSafeArea", "verticalCompressionResistancePriority", "placeholderIntrinsicWidth", "multipleTouchEnabled", "clearsContextBeforeDrawing", "contentMode", "ambiguous", "id", "key", "verticalHuggingPriority", "opaque", "misplaced", "userLabel", "clipsSubviews", "fixedFrame", "placeholderIntrinsicHeight", "userInteractionEnabled", "tag", "horizontalHuggingPriority", "alpha", "autoresizesSubviews"],
//    "collectionView": ["dataMode"],
//    "collectionViewCell": [],
//    "collectionReusableView": [],
//    "tableView": ["contentInsetAdjustmentBehavior",
//                "contentViewInsetsToSafeArea", "estimatedSectionHeaderHeight", "sectionIndexMinimumDisplayRowCount", "estimatedRowHeight", "separatorStyle", "style", "allowsSelection", "estimatedSectionFooterHeight", "rowHeight", "sectionFooterHeight", "sectionHeaderHeight"]
//    "tableViewCell": ["rowHeight", "preservesSuperviewLayoutMargins", "selectionStyle", "reuseIdentifier", "indentationWidth"],
//    "tableViewCellContentView": ["preservesSuperviewLayoutMargins", "tableViewCell"],
//    "stackView": ["alignment", "spacing", "customModuleProvider", "distribution", "semanticContentAttribute", "axis"],
//    "scrollView": ["directionalLockEnabled", "pagingEnabled", "keyboardDismissMode", "alwaysBounceHorizontal", "delaysContentTouches", "alwaysBounceVertical", "scrollEnabled", "bouncesZoom", "showsHorizontalScrollIndicator", "showsVerticalScrollIndicator", "bounces"]
//    "activityIndicatorView": ["style", "hidesWhenStopped"]
//    "imageView": ["image", "adjustsImageSizeForAccessibilityContentSizeCategory", "highlightedImage"]
//    "pickerView": []
//    "progressView": []
//    "control": []
//    "button": ["enabled", "adjustsImageWhenHighlighted", "hasAttributedTitle", "lineBreakMode", "contentVerticalAlignment", "buttonType", "contentHorizontalAlignment", "semanticContentAttribute", "selected"]
//    "datePicker": ["contentHorizontalAlignment", "contentVerticalAlignment", "datePickerMode", "style"]
//    "pageControl": ["hidesForSinglePage", "numberOfPages", "enabled", "contentHorizontalAlignment", "contentVerticalAlignment"]
//    "segmentedControl": ["selectedSegmentIndex", "segmentControlStyle", "contentVerticalAlignment", "contentHorizontalAlignment"]
//    "slider": ["maxValue", "contentHorizontalAlignment", "minValue", "value", "contentVerticalAlignment"]
//    "switch": ["contentVerticalAlignment", "on", "contentHorizontalAlignment"]
//    "label": ["adjustsLetterSpacingToFitWidth", "text", "textAlignment", "minimumFontSize", "lineBreakMode", "minimumScaleFactor", "usesAttributedText", "numberOfLines", "baselineAdjustment", "adjustsFontForContentSizeCategory", "adjustsFontSizeToFit"]
//    "textView": ["textAlignment", "usesAttributedText", "text", "editable", "selectable"]
//    "visualEffectView": []
//    "searchBar": ["showsCancelButton", "searchBarStyle", "backgroundImage", "placeholder"]
//]

#if DEBUG
import Foundation
public let protocolInheritance = """
public protocol XibViewProtocol: XibElementProtocol {
public protocol XibCollectionViewProtocol: XibScrollViewProtocol {
public protocol XibCollectionViewCellProtocol: XibCollectionReusableViewProtocol {
public protocol XibCollectionReusableViewProtocol: XibViewProtocol {
public protocol XibCollectionViewFlowLayoutProtocol {
public protocol XibTableViewProtocol: XibScrollViewProtocol {
public protocol XibTableViewCellProtocol: XibViewProtocol {
public protocol XibTableViewCellContentViewProtocol: XibViewProtocol {
public protocol XibStackViewProtocol: XibViewProtocol {
public protocol XibScrollViewProtocol: XibViewProtocol {
public protocol XibActivityIndicatorViewProtocol: XibViewProtocol {
public protocol XibImageViewProtocol: XibViewProtocol {
public protocol XibPickerViewProtocol: XibViewProtocol {
public protocol XibProgressViewProtocol: XibViewProtocol {
public protocol XibControlProtocol: XibViewProtocol {
public protocol XibButtonProtocol: XibControlProtocol {
public protocol XibDatePickerProtocol: XibControlProtocol {
public protocol XibPageControlProtocol: XibControlProtocol {
public protocol XibSegmentedControlProtocol: XibControlProtocol {
public protocol XibSliderProtocol: XibControlProtocol {
public protocol XibSwitchProtocol: XibControlProtocol {
public protocol XibLabelProtocol: XibViewProtocol {
public protocol XibTextField: XibControlProtocol {
public protocol XibTextViewProtocol: XibScrollViewProtocol {
public protocol XibVisualEffectViewProtocol: XibViewProtocol {
public protocol XibSearchBarProtocol: XibViewProtocol {
"""

import RegexBuilder
let regex = Regex {
    "public protocol "
    "Xib"
    Capture{
        OneOrMore(.word)
    }
    "Protocol"
    ": Xib"
    Capture {
        OneOrMore(.word)
    }
    "Protocol {"
}

public class InheritanceTree {
    var value: String
    public var tags: Set<String>
    weak var parent: InheritanceTree?
    var childs: [InheritanceTree] = []
    
    public init(
        _ value: String,
        _ tags: [String],
        _ parent: InheritanceTree? = nil
    ) {
        self.value = value
        self.parent = parent
        self.tags = Set<String>()
        for tag in tags {
            if !InheritanceTree.find(in: parent, tag: tag) {
                self.tags.insert(tag)
            }
        }
        self.parent?.childs.append(self)
    }
    
    func findInParent(tag: String) -> Bool {
        if let parent, parent.findInParent(tag: tag) || parent.findInSelf(tag: tag) {
            return true
        }
        return false
        
    }
    
    func findInSelf(tag: String) -> Bool {
        return tags.contains(tag)
    }
    
    static func find(in node: InheritanceTree?, tag: String) -> Bool {
        if let node, node.findInParent(tag: tag) || node.findInSelf(tag: tag) {
            return true
        }
        return false
    }
    
    private func printTagExpresion() {
        let expression = """
        "\(self.value)": [
        \t\(self.tags.sorted().map({"\"\($0)\""}).joined(separator: ",\n\t"))],
        """
        print( expression )
    }
    
    /// print expression for your self and child
    public func printAllTagExpressionsSelfAndChild() {
        self.printTagExpresion()
        for child in childs {
            child.printAllTagExpressionsSelfAndChild()
        }
    }
    
    private func printInitExpression() {
        var parentName: String
        if let parent {
            parentName = "my" + parent.value
        }else{
            parentName = "nil"
        }
        //        parentName = "my" + parentName
        let initName = "my" + self.value
        let expression = (self.value == "control") ?
        """
        let \(initName) = InheritanceTree("\(value)", [], \(parentName)
                )
        """ :
        """
        let \(initName) = InheritanceTree("\(value)", tagAttributeDicts["\(value)"]!.keys.sorted(), \(parentName)
        )
        """
        print(expression)
    }
    
    public func printAllInitExpressionsSelfAndChild() {
        self.printInitExpression()
        for child in childs {
            child.printAllInitExpressionsSelfAndChild()
        }
    }
}

let myview = InheritanceTree("view", tagAttributeDicts["view"]!.keys.sorted(), nil
)
let myscrollView = InheritanceTree("scrollView", tagAttributeDicts["scrollView"]!.keys.sorted(), myview
)
let mycollectionView = InheritanceTree("collectionView", tagAttributeDicts["collectionView"]!.keys.sorted(), myscrollView
)
let mytableView = InheritanceTree("tableView", tagAttributeDicts["tableView"]!.keys.sorted(), myscrollView
)
let mytextView = InheritanceTree("textView", tagAttributeDicts["textView"]!.keys.sorted(), myscrollView
)
let mycollectionReusableView = InheritanceTree("collectionReusableView", tagAttributeDicts["collectionReusableView"]!.keys.sorted(), myview
)
let mycollectionViewCell = InheritanceTree("collectionViewCell", tagAttributeDicts["collectionViewCell"]!.keys.sorted(), mycollectionReusableView
)
let mytableViewCell = InheritanceTree("tableViewCell", tagAttributeDicts["tableViewCell"]!.keys.sorted(), myview
)
let mytableViewCellContentView = InheritanceTree("tableViewCellContentView", tagAttributeDicts["tableViewCellContentView"]!.keys.sorted(), myview
)
let mystackView = InheritanceTree("stackView", tagAttributeDicts["stackView"]!.keys.sorted(), myview
)
let myactivityIndicatorView = InheritanceTree("activityIndicatorView", tagAttributeDicts["activityIndicatorView"]!.keys.sorted(), myview
)
let myimageView = InheritanceTree("imageView", tagAttributeDicts["imageView"]!.keys.sorted(), myview
)
let mypickerView = InheritanceTree("pickerView", tagAttributeDicts["pickerView"]!.keys.sorted(), myview
)
let myprogressView = InheritanceTree("progressView", tagAttributeDicts["progressView"]!.keys.sorted(), myview
)
let mycontrol = InheritanceTree("control", [], myview
)
let mybutton = InheritanceTree("button", tagAttributeDicts["button"]!.keys.sorted(), mycontrol
)
let mydatePicker = InheritanceTree("datePicker", tagAttributeDicts["datePicker"]!.keys.sorted(), mycontrol
)
let mypageControl = InheritanceTree("pageControl", tagAttributeDicts["pageControl"]!.keys.sorted(), mycontrol
)
let mysegmentedControl = InheritanceTree("segmentedControl", tagAttributeDicts["segmentedControl"]!.keys.sorted(), mycontrol
)
let myslider = InheritanceTree("slider", tagAttributeDicts["slider"]!.keys.sorted(), mycontrol
)
let myswitch = InheritanceTree("switch", tagAttributeDicts["switch"]!.keys.sorted(), mycontrol
)
let mylabel = InheritanceTree("label", tagAttributeDicts["label"]!.keys.sorted(), myview
)
let myvisualEffectView = InheritanceTree("visualEffectView", tagAttributeDicts["visualEffectView"]!.keys.sorted(), myview
)
let mysearchBar = InheritanceTree("searchBar", tagAttributeDicts["searchBar"]!.keys.sorted(), myview
)

let protocolTagDict = [
    "view": [
        "alpha",
        "ambiguous",
        "autoresizesSubviews",
        "clearsContextBeforeDrawing",
        "clipsSubviews",
        "contentMode",
        "customClass",
        "fixedFrame",
        "hidden",
        "horizontalCompressionResistancePriority",
        "horizontalHuggingPriority",
        "id",
        "insetsLayoutMarginsFromSafeArea",
        "key",
        "misplaced",
        "multipleTouchEnabled",
        "opaque",
        "placeholderIntrinsicHeight",
        "placeholderIntrinsicWidth",
        "tag",
        "translatesAutoresizingMaskIntoConstraints",
        "userInteractionEnabled",
        "userLabel",
        "verifyAmbiguity",
        "verticalCompressionResistancePriority",
        "verticalHuggingPriority"],
    "scrollView": [
        "alwaysBounceHorizontal",
        "alwaysBounceVertical",
        "bounces",
        "bouncesZoom",
        "delaysContentTouches",
        "directionalLockEnabled",
        "keyboardDismissMode",
        "pagingEnabled",
        "scrollEnabled",
        "showsHorizontalScrollIndicator",
        "showsVerticalScrollIndicator"],
    "collectionView": [
        "dataMode"],
    "tableView": [
        "allowsSelection",
        "contentInsetAdjustmentBehavior",
        "contentViewInsetsToSafeArea",
        "estimatedRowHeight",
        "estimatedSectionFooterHeight",
        "estimatedSectionHeaderHeight",
        "rowHeight",
        "sectionFooterHeight",
        "sectionHeaderHeight",
        "sectionIndexMinimumDisplayRowCount",
        "separatorStyle",
        "style"],
    "textView": [
        "editable",
        "selectable",
        "text",
        "textAlignment",
        "usesAttributedText"],
    "collectionReusableView": [
        ],
    "collectionViewCell": [
        ],
    "tableViewCell": [
        "indentationWidth",
        "preservesSuperviewLayoutMargins",
        "reuseIdentifier",
        "rowHeight",
        "selectionStyle"],
    "tableViewCellContentView": [
        "preservesSuperviewLayoutMargins",
        "tableViewCell"],
    "stackView": [
        "alignment",
        "axis",
        "customModuleProvider",
        "distribution",
        "semanticContentAttribute",
        "spacing"],
    "activityIndicatorView": [
        "hidesWhenStopped",
        "style"],
    "imageView": [
        "adjustsImageSizeForAccessibilityContentSizeCategory",
        "highlightedImage",
        "image"],
    "pickerView": [
        ],
    "progressView": [
        ],
    "control": [
        ],
    "button": [
        "adjustsImageWhenHighlighted",
        "buttonType",
        "contentHorizontalAlignment",
        "contentVerticalAlignment",
        "enabled",
        "hasAttributedTitle",
        "lineBreakMode",
        "selected",
        "semanticContentAttribute"],
    "datePicker": [
        "contentHorizontalAlignment",
        "contentVerticalAlignment",
        "datePickerMode",
        "style"],
    "pageControl": [
        "contentHorizontalAlignment",
        "contentVerticalAlignment",
        "enabled",
        "hidesForSinglePage",
        "numberOfPages"],
    "segmentedControl": [
        "contentHorizontalAlignment",
        "contentVerticalAlignment",
        "segmentControlStyle",
        "selectedSegmentIndex"],
    "slider": [
        "contentHorizontalAlignment",
        "contentVerticalAlignment",
        "maxValue",
        "minValue",
        "value"],
    "switch": [
        "contentHorizontalAlignment",
        "contentVerticalAlignment",
        "on"],
    "label": [
        "adjustsFontForContentSizeCategory",
        "adjustsFontSizeToFit",
        "adjustsLetterSpacingToFitWidth",
        "baselineAdjustment",
        "lineBreakMode",
        "minimumFontSize",
        "minimumScaleFactor",
        "numberOfLines",
        "text",
        "textAlignment",
        "usesAttributedText"],
    "visualEffectView": [
        ],
    "searchBar": [
        "backgroundImage",
        "placeholder",
        "searchBarStyle",
        "showsCancelButton"],
]
#endif
