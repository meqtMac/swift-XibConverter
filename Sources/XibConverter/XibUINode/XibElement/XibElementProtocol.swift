//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/7/6.
//
import Foundation

protocol XmlElementInitable {
    init(attributes: [String: String]) throws
}

protocol XibElement: XmlElementInitable { }

protocol XibViewProtocol: XibElement {
    var id: String { get }
}

protocol XibTextViewProtocol: XibViewProtocol {
    
}
protocol XibButtonProtocol: XibViewProtocol {
    
}
protocol XibLabelProtocol: XibViewProtocol {
    
}
protocol XibPageControlProtocol: XibViewProtocol {
    
}
protocol XibImageViewProtocol: XibViewProtocol {
    
}
/// Xib Connection
protocol XibConnectionElement: XibElement { }

/** Xib Outlet
 ### XML IB example
 ```xml
 <connections>
     <outlet property="acceptContainView" destination="Olm-Jm-QjG" id="ZZC-Vd-Sy1"/>
     <outlet property="acceptManName" destination="22x-Pw-WeO" id="Rks-1Z-TNB"/>
</connections>
 ```
 */
protocol XibOutletProtocol: XibConnectionElement {
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
protocol XibActionProtocol: XibConnectionElement {
    associatedtype EventType
    var selector: String { get }
    var destionation: String { get }
    var eventType: EventType { get }
    var id: String { get }
}


protocol XibResourceElement: XibElement {
    
}

/** Property of a view
 ```xml
 <rect key="frame" x="0.0" y="0.0" width="320" height="568"/>
 <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
 <color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/>
 <point key="canvasLocation" x="90.5" y="128.5"/>
 ```
 */
protocol XibPropertyElement: XibElement {
    var key: String { get }
}

protocol XibColorProtocol: XibPropertyElement {
}
protocol XibImageProtocol: XibPropertyElement {
    
}

protocol XibAutoResizingMaskProtocol: XibPropertyElement {
}

protocol XibStringProtocol: XibPropertyElement {
    
}

protocol XibFontDescriptionProtocol: XibPropertyElement {
    
}
protocol XibTextInputTraitsProtocol: XibPropertyElement {
    
}
protocol XibDataDetectorTypeProtocol: XibPropertyElement {
    
}
protocol XibCustomNilProtocol: XibPropertyElement {
    
}
protocol XibStateProtocol: XibPropertyElement {
    
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
protocol XibConstraintProtocol: XibElement {
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

protocol XibSubViewProtocol: XibElement, Identifiable {
    var parentID: String { get }
    var childrenID: [String] { get set }
    mutating func addchildID(id: String) 
}

