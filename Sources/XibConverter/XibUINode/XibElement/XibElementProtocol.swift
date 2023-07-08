//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/6.
//
import Foundation
//import UIKit

public protocol XmlElementInitable {
    init(attributes: [String: String]) throws
}

public protocol XibElement: XmlElementInitable { }

/// `UIKit.UIView.ContentMode`
public enum XibContentMode: String {
    case scaleToFill
    case scaleAspectFit
    case scaleAspectFill
    case redraw
    case center
    case top
    case bottom
    case left
    case right
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

public enum XibScrollViewKeyboardDismissMode: String {
    case none
    case onDrag
    case interactive
    case onDragWithAccessory
    case interactiveWithAccessory
}

/// `UIKit.UIView`
public protocol XibViewProtocol: XibElement {
    var id: String { get }
   
    // TODO: horizontalHuggingPriority -> setContentHuggingPriority
    /// `UIKit.UILayoutPriority`
    var horizontalHuggingPriority: Float? { get }
    var verticalHuggingPriority: Float? { get }
    
    /// `UIKit.UIView.setContentCompressionResistancePriority`
    var horizontalCompressionResistancePriority: Float? { get }
    var verticalCompressionResistancePriority: Float? { get }
    
    
    // get from key <color key="backgroundColor"
    var backgroundColor: XibColor? { get set }
 
    // hidden: ["YES"]
    var isHidden: Bool? { get }
    // alpha: ["0.9000000002"]
    var alpha: CGFloat? { get }
    // "opaque":        ["NO"]
    var isOpaque: Bool? { get }
    
    var tintColor: XibColor? { get set }
    
    // "clipsSubviews":        ["YES"]
    var clipToBounds: Bool? { get }
    
    // "clearsContextBeforeDrawing":        ["NO"]
    var clearsContextBeforeDrawing: Bool? { get }
    
    // "userInteractionEnabled":        ["NO"]
    var isUserInteractionEnabled: Bool? { get }
    
    // "multipleTouchEnabled":        ["YES"]
    var isMultiplerTouchEnabled: Bool? { get }
    
    // "insetsLayoutMarginsFromSafeArea":        ["NO"]
    var insetsLayoutMarginsFromSafeArea: Bool? { get }
    
    // TODO: ?? "ambiguous":        ["YES"],
    var hasAmbiguousLayout: Bool? { get }
   
    // "contentMode":        ["scaleAspectFill", "scaleToFill", "center", "scaleAspectFit"]
    var contentMode: XibContentMode? { get }
    
 
    // "autoresizesSubviews":        ["NO"]
    var autoresizesSubviews: Bool? { get }
    
    var translatesAutoresizingMaskIntoConstraints: Bool? { get }
    
    
    var tag: Int? { get }
    
    // "placeholderIntrinsicWidth":        ["375"],
    var placeholderIntrinsicWidth: CGFloat? { get }
    
    // "placeholderIntrinsicHeight":        ["128"]
    var placeholderIntrinsicHeight: CGFloat? { get }
    
    // "customClass":        ["WPPoseComposePhotoCollectionView"]
    var customClass: String? { get }
}

/// `UIKit.UICollectionView`
public protocol XibCollectionViewProtocol: XibScrollViewProtocol {
    
    // "dataMode":        ["none"]
    var dataMode: String? { get }
}

/// `UIKit.UICollectionViewCell`
public protocol XibCollectionViewCellProtocol: XibCollectionReusableViewProtocol {
    
}

/// `UIKit.UICollectionReusableView`
public protocol XibCollectionReusableViewProtocol: XibViewProtocol {
    
}

/// `UIKit.UICollectionViewFlowLayout`
public protocol XibCollectionViewFlowLayoutProtocol {
    
}

/// `UIKit.UITableView`
public protocol XibTableViewProtocol: XibScrollViewProtocol {
}


/// `UIKit.UITableViewCell`
public protocol XibTableViewCellProtocol: XibViewProtocol {
    
}

//  MARK:  ??
public protocol XibTableViewCellContentViewProtocol: XibViewProtocol {
    
}

/// `UIKit.UIStackView`
public protocol XibStackViewProtocol: XibViewProtocol {
    
}

/// `UIKit.ScrollView`
public protocol XibScrollViewProtocol: XibViewProtocol {
        
    // "scrollEnabled":        ["NO"]
    var isScrollEnabled: Bool? { get }
    // "directionalLockEnabled":        ["YES"],
    var isDirectionalLockEnabled: Bool? { get }
    
    // "pagingEnabled":        ["YES"]
    var isPagingEnabled: Bool? { get }
    
    // "bounces":        ["NO"]
    var bounces: Bool? { get }
    
    // "alwaysBounceVertical":        ["YES"]
    var alwaysBounceVertical: Bool? { get }
    
    //  "alwaysBounceHorizontal":        ["YES"]
    var alwaysBounceHorizontal: Bool? { get }
    
    // "showsHorizontalScrollIndicator":        ["NO"]
    var showsHorizontalScrollIndicator: Bool? { get }
    
    // "showsVerticalScrollIndicator":        ["NO"]
    var showsVerticalScrollIndicator: Bool? { get }
    
    // "delaysContentTouches":        ["NO"]
    var delaysContentTouches: Bool?  { get }
    
    // "bouncesZoom": ["NO"]
    var bouncesZoom: Bool? { get }
    
    var keyboardDismissMode: XibScrollViewKeyboardDismissMode { get }
 
}

/// `UIKit.ActivityIndicatorView`
public protocol XibActivityIndicatorViewProtocol: XibViewProtocol {
    
}

/// `UIKit.UIImageView`
public protocol XibImageViewProtocol: XibViewProtocol {
}

/// `UIKit.UIPickerView`
public protocol XibPickerViewProtocol: XibViewProtocol {
    
}

/// `UIKit.UIProgressView`
public protocol XibProgressViewProtocol: XibViewProtocol {
    
}

/// `UIKit.UIControl`
public protocol XibControlProtocol: XibViewProtocol {
    
}

/// `UIKit.UIButton`
public protocol XibButtonProtocol: XibControlProtocol {
    
}

/// `UIKit.UIDatePicker`
public protocol XibDatePickerProtocol: XibControlProtocol {
    
}

/// `UIKit.UIPageControl`
public protocol XibPageControlProtocol: XibControlProtocol {
    
}

/// `UIKit.UISegmentedControl`
public protocol XibSegmentedControlProtocol: XibControlProtocol {
    
}

/// `UIKit.Slider`
public protocol XibSliderProtocol: XibControlProtocol {
    
}

/// `UIKit.UISwitch`
public protocol XibSwitchProtocol: XibControlProtocol {
    
}

/// `UIKit.UILabel`
public protocol XibLabelProtocol: XibViewProtocol {
    
}

/// `UIKit.UITextField`
public protocol XibTextField: XibControlProtocol {
    
}

/// `UIKit.UITextView`
public protocol XibTextViewProtocol: XibScrollViewProtocol {
    
}

/// `UIKit.UIVisualEffectView`
public protocol XibVisualEffectViewProtocol: XibViewProtocol {
    
}

/// `UIKit.UIVisualEffect`
public protocol XibVisualEffectProtocol: XibElement {
    
}

/// `UIKit.UIBlurEffect`
public protocol XibBlurEffectProtocol: XibVisualEffectProtocol {
    
}

/// `UIKit.UIVibrancyEffect`
public protocol XibVibrancyEffect: XibVisualEffectProtocol {
    
}

/// `UIKit.UISearchBar`
public protocol XibSearchBarProtocol: XibViewProtocol {
    
}

/// `UIKit.UIEdgeInsets`
public protocol XibEdgeInsetsProtocol: XibElement {
    var bottom: CGFloat { get }
    var left: CGFloat { get }
    var right: CGFloat { get }
    var top: CGFloat { get }
    init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
}

//
//public protocol XibTextViewProtocol: XibViewProtocol {
//}
//
//public protocol XibButtonProtocol: XibViewProtocol {
//    
//}
//public protocol XibLabelProtocol: XibViewProtocol {
//    
//}
//public protocol XibPageControlProtocol: XibViewProtocol {
//    
//}


/// Xib Connection
public protocol XibConnectionElement: XibElement { }

/** Xib Outlet
 ### XML IB example
 ```xml
 <connections>
     <outlet property="acceptContainView" destination="Olm-Jm-QjG" id="ZZC-Vd-Sy1"/>
     <outlet property="acceptManName" destination="22x-Pw-WeO" id="Rks-1Z-TNB"/>
</connections>
 ```
 */
public protocol XibOutletProtocol: XibConnectionElement {
    var property: String { get }
    var destination: String { get }
    var id: String { get }
}

/** Xib Action
 ### XML IB example
 ```xml
 <connections>
     <action selector="jumpRule:" destination="-1" eventType="touchUpInside" id="4cw-dU-22B"/>
 </connections>
```
 */
public protocol XibActionProtocol: XibConnectionElement {
    associatedtype EventType
    var selector: String { get }
    var destionation: String { get }
    var eventType: EventType { get }
    var id: String { get }
}


public protocol XibResourceElement: XibElement {
    
}

/** Property of a view
 ```xml
 <rect key="frame" x="0.0" y="0.0" width="320" height="568"/>
 <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
 <color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/>
 <point key="canvasLocation" x="90.5" y="128.5"/>
 ```
 */
public protocol XibPropertyElement: XibElement {
    var key: String { get }
}

public protocol XibColorProtocol: XibPropertyElement {
}
public protocol XibImageProtocol: XibPropertyElement {
    
}

public protocol XibAutoResizingMaskProtocol: XibPropertyElement {
}

public protocol XibStringProtocol: XibPropertyElement {
    
}

public protocol XibFontDescriptionProtocol: XibPropertyElement {
    
}
public protocol XibTextInputTraitsProtocol: XibPropertyElement {
    
}
public protocol XibDataDetectorTypeProtocol: XibPropertyElement {
    
}
public protocol XibCustomNilProtocol: XibPropertyElement {
    
}
public protocol XibStateProtocol: XibPropertyElement {
    
}


/** Xib Constraint
 ```xml
 <constraint firstAttribute="width" constant="50" id="9ac-dE-DHf"/>
 <constraint firstAttribute="height" constant="16" id="AwC-AX-dCg"/>
 <constraint firstAttribute="bottom" secondItem="xo2-BJ-Rzb" secondAttribute="bottom" constant="2" id="5yY-9P-clT"/>
 <constraint firstItem="UfQ-FA-8fT" firstAttribute="top" secondItem="iN0-l3-epB" secondAttribute="top" id="JqQ-ue-YG9"/>
 <constraint firstAttribute="width" secondItem="Fgp-vx-obw" secondAttribute="height" multiplier="265:14" id="xM4-tE-1T3"/>
 ```
 */
public protocol XibConstraintProtocol: XibElement {
    associatedtype Item: Equatable
    associatedtype ConstraintAttribute
    
    var firstItem: Item { get }
    var firstAttribute: ConstraintAttribute { get }
    var secondItem: Item { get }
    var secondAttribute: ConstraintAttribute { get }
    
    var multipler: CGFloat { get }
    var constant: CGFloat { get }
    var id: String { get }
}

public protocol XibSubViewProtocol: XibElement, Identifiable {
    var parentID: String { get }
    var childrenID: [String] { get set }
    mutating func addchildID(id: String) 
}

