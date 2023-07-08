//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/7/6.
//

import Foundation

/// Serialize Xib Documents
public enum XibUINode: String {
    /// ``XibViewProtocol``
    case view
    
    /** ``XibCollectionViewProtocol``
     
     ```xml
     <collectionView clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="scaleToFill" dataMode="none" translatesAutoresizingMaskIntoConstraints="NO" id="gPM-w2-kh5">
     <rect key="frame" x="8" y="6" width="420" height="338"/>
     <color key="backgroundColor" white="0.0" alpha="0.0" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
     <collectionViewFlowLayout key="collectionViewLayout" minimumLineSpacing="0.0" minimumInteritemSpacing="0.0" id="UuF-M9-zpM">
     <size key="itemSize" width="44" height="44"/>
     <size key="headerReferenceSize" width="0.0" height="0.0"/>
     <size key="footerReferenceSize" width="0.0" height="0.0"/>
     <inset key="sectionInset" minX="0.0" minY="0.0" maxX="0.0" maxY="0.0"/>
     </collectionViewFlowLayout>
     <connections>
     <outlet property="dataSource" destination="-1" id="THp-He-cI5"/>
     <outlet property="delegate" destination="-1" id="n0E-hi-ztP"/>
     </connections>
     </collectionView>
     ```
     */
    case collectionView
    
    /// ``XibCollectionViewCellProtocol``
    case collectionViewCell
    /// ``XibCollectionReusableViewProtocol``
    case collectionReusableView
    
    /// ``XibCollectionViewFlowLayoutProtocol``
    case collectionViewFlowLayout
    /**
    ```xml
     <collectionViewCell opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" id="gTV-IL-0wX" customClass="HWNestRingBoxCell">
    ```
     */
    
    /**
     ```xml
     <collectionReusableView opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" id="U6b-Vx-4bR">
     ```
     */
    
     /** ``XibTableViewProtocol``
      
     a table view (must?) have two outlet
      
     ```xml
     <connections>
     <outlet property="dataSource" destination="-1" id="rsT-xZ-gds"/>
     <outlet property="delegate" destination="-1" id="aJp-DZ-Yub"/>
     </connections>
     ```
     ```xml
     <tableView opaque="NO" clipsSubviews="YES" clearsContextBeforeDrawing="NO" contentMode="scaleToFill" bouncesZoom="NO" style="plain" separatorStyle="default" rowHeight="44" sectionHeaderHeight="22" sectionFooterHeight="22" id="i5M-Pr-FkT">
     <rect key="frame" x="0.0" y="0.0" width="375" height="667"/>
     <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
     <color key="backgroundColor" red="1" green="1" blue="1" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
     <viewLayoutGuide key="safeArea" id="NQg-xp-Ubj"/>
     <connections>
     <outlet property="dataSource" destination="-1" id="Tng-2m-Rnh"/>
     <outlet property="delegate" destination="-1" id="9aC-8N-iBw"/>
     </connections>
     </tableView>
     ```
     a tableView can have two key as attributes
     ```xml
     <view key="tableHeaderView" contentMode="scaleToFill" id="2HA-aL-L1P" userLabel="HeaderView">
     </view>
     <view key="tableFooterView" contentMode="scaleToFill" id="uaO-N9-PCx" userLabel="FooterView">
     </view>
     ```
     */
    case tableView
    /** ``XibTableViewCellProtocol``
     
     ```xml
     <tableViewCell contentMode="scaleToFill" selectionStyle="default" indentationWidth="10" id="KGk-i7-Jjw" customClass="WPSingleHeadCell">
     ```
     */
    case tableViewCell
    /**
     used inside tableViewCell
     ```xml
     <tableViewCellContentView key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" tableViewCell="KGk-i7-Jjw" id="H2p-sc-9uM">
     ```
     */
    case tableViewCellContentView
    
     /** ``XibStackViewProtocol``
      
     ```xml
     <stackView opaque="NO" contentMode="scaleToFill" alignment="center" spacing="2" translatesAutoresizingMaskIntoConstraints="NO" id="Hnl-zM-uxy">
     ```
     */
    case stackView
    
     /** ``XibScrollViewProtocol``
      
     ```xml
     <scrollView clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="scaleToFill" ambiguous="YES" showsHorizontalScrollIndicator="NO" showsVerticalScrollIndicator="NO" translatesAutoresizingMaskIntoConstraints="NO" id="RMN-EF-X0o">
     </scrollView>
     ```
     */
    case scrollView
     /** ``XibActivityIndicatorViewProtocol``
      
     ```xml
     <activityIndicatorView opaque="NO" tag="105" contentMode="scaleToFill" horizontalHuggingPriority="750" verticalHuggingPriority="750" style="gray" translatesAutoresizingMaskIntoConstraints="NO" id="y4x-al-5Sq">
         <rect key="frame" x="133.5" y="56" width="20" height="20"/>
     </activityIndicatorView>
     ```
     */
    case activityIndicatorView
    
    /// ``XibImageViewProtocol``
    case imageView


     /** ``XibPickerViewProtocol``
      
     ```xml
     <pickerView contentMode="scaleToFill" translatesAutoresizingMaskIntoConstraints="NO" id="5TG-lS-Z9T">
         <rect key="frame" x="0.0" y="44" width="375" height="216"/>
         <connections>
             <outlet property="dataSource" destination="-1" id="yfP-Bq-5NN"/>
             <outlet property="delegate" destination="-1" id="Nug-IX-5pu"/>
         </connections>
     </pickerView>
     ```
     */
    case pickerView
    
    /** ``XibProgressViewProtocol``
     
     ```xml
     <progressView opaque="NO" contentMode="scaleToFill" verticalHuggingPriority="750" placeholderIntrinsicWidth="329" placeholderIntrinsicHeight="4" translatesAutoresizingMaskIntoConstraints="NO" id="QUF-q5-4aG">
         <rect key="frame" x="16" y="65" width="326" height="4"/>
         <constraints>
             <constraint firstAttribute="height" constant="4" id="13j-cO-Li5"/>
         </constraints>
         <color key="progressTintColor" red="0.83137254900000002" green="1" blue="0.8862745098" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
         <color key="trackTintColor" red="0.34509803921568627" green="0.73725490196078436" blue="0.047058823529411764" alpha="0.0" colorSpace="custom" customColorSpace="sRGB"/>
     </progressView>
     ```
     */
    case progressView
 
    /// ``XibButtonProtocol``
    case button
    
     /** ``XibDatePickerProtocol``
      
     used only once in 1062 xib file
     ```xml
     <datePicker contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" datePickerMode="date" style="wheels" translatesAutoresizingMaskIntoConstraints="NO" id="JSh-HE-hQS">
     <rect key="frame" x="0.0" y="60" width="421" height="278"/>
     <locale key="locale" localeIdentifier="zh_CN"/>
     </datePicker>
     ```
     */
    case datePicker
    
     /** ``XibPageControlProtocol``
      
     ```xml
     <pageControl opaque="NO" contentMode="scaleToFill" enabled="NO" contentHorizontalAlignment="center" contentVerticalAlignment="center" numberOfPages="3" translatesAutoresizingMaskIntoConstraints="NO" id="8q3-dv-Ne9">
     <rect key="frame" x="0.0" y="295" width="413" height="22"/>
     <color key="backgroundColor" white="0.0" alpha="0.0" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
     <constraints>
     <constraint firstAttribute="height" constant="22" id="poi-DH-wdh"/>
     </constraints>
     </pageControl>
     ```
     */
    case pageControl
 
    /** ``XibSegmentedControlProtocol``
     
     ```xml
     <segmentedControl opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="top" segmentControlStyle="plain" selectedSegmentIndex="0" translatesAutoresizingMaskIntoConstraints="NO" id="GKz-31-1UO">
     <rect key="frame" x="78.5" y="212" width="257" height="32"/>
     <segments>
     <segment title="服务器指定"/>
     <segment title="腾讯云"/>
     <segment title="即构"/>
     </segments>
     <color key="selectedSegmentTintColor" red="0.8980392157" green="1" blue="0.89019607840000003" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
     <connections>
     <action selector="onValueChanged:" destination="-1" eventType="valueChanged" id="sU0-B0-h8B"/>
     </connections>
     </segmentedControl>
     ```
     */
    case segmentedControl
    /// `segmentedControl` parsing environment
    case segments
    /// segment properity
    case segment
    
     /** ``XibSliderProtocol``
      
     ```xml
     <slider opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" minValue="0.0" maxValue="1" translatesAutoresizingMaskIntoConstraints="NO" id="32Q-82-d4m">
     <rect key="frame" x="14" y="502" width="347" height="31"/>
     <color key="tintColor" red="0.14117647058823529" green="0.77254901960784317" blue="0.44705882352941173" alpha="1" colorSpace="calibratedRGB"/>
     </slider>
     ```
     */
    case slider
    
     /** ``XibSwitchProtocol``
      
     ```xml
     <switch opaque="NO" contentMode="scaleToFill" horizontalHuggingPriority="750" verticalHuggingPriority="750" contentHorizontalAlignment="center" contentVerticalAlignment="center" translatesAutoresizingMaskIntoConstraints="NO" id="irx-u0-CNm">
     <rect key="frame" x="255" y="8.5" width="51" height="31"/>
     <connections>
     <action selector="onSwitchValueChanged:" destination="KGk-i7-Jjw" eventType="valueChanged" id="qgr-bo-OoU"/>
     </connections>
     </switch>
     ```
     */
    case customSwitch = "switch"
 
    /// ``XibLabelProtocol``
    case label
    
   /** ``XibTextField``
    
     ```xml
     <textField opaque="NO" clipsSubviews="YES" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="center" minimumFontSize="17" clearButtonMode="whileEditing" translatesAutoresizingMaskIntoConstraints="NO" id="vuI-Rg-Vc4" customClass="WPLimitedTextField">
         <rect key="frame" x="15" y="0.0" width="345" height="45"/>
         <color key="textColor" red="0.20392156862745098" green="0.20392156862745098" blue="0.20392156862745098" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
         <fontDescription key="fontDescription" type="system" pointSize="16"/>
         <textInputTraits key="textInputTraits"/>
     </textField>
     ```
     */
    case textField
      /// ``XibTextViewProtocol``
    case textView
 
    /** ``XibVisualEffectViewProtocol``
     example
     
     ```xml
     <visualEffectView
     opaque="NO"
     contentMode="scaleToFill"
     translatesAutoresizingMaskIntoConstraints="NO"
     id="I8e-RA-MzL">
     <rect
     key="frame"
     x="0.0"
     y="0.0"
     width="375"
     height="384.66666666666669"/>
     <view key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" insetsLayoutMarginsFromSafeArea="NO" id="4wJ-SE-kmb">
     <rect key="frame" x="0.0" y="0.0" width="375" height="384.66666666666669"/>
     <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
     </view>
     <blurEffect style="dark"/>
     </visualEffectView>
     ```
     */
    case visualEffectView
    
    /** ``XibBlurEffectProtocol``
     
     used in visualEffectView
     ```xml
     <visualEffectView opaque="NO" contentMode="scaleToFill" translatesAutoresizingMaskIntoConstraints="NO" id="I8e-RA-MzL">
     <rect key="frame" x="0.0" y="0.0" width="375" height="384.66666666666669"/>
     <view key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" insetsLayoutMarginsFromSafeArea="NO" id="4wJ-SE-kmb">
     <rect key="frame" x="0.0" y="0.0" width="375" height="384.66666666666669"/>
     <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
     </view>
     <blurEffect style="dark"/>
     </visualEffectView>
     ```
     */
    case blurEffect
 
    /** ``XibSearchBarProtocol``
     
     ```xml
     <searchBar contentMode="scaleAspectFill" placeholder="搜索昵称、备注" backgroundImage="home_empty" translatesAutoresizingMaskIntoConstraints="NO" id="Fye-dn-pTB">
         <rect key="frame" x="0.0" y="8" width="343" height="36"/>
         <constraints>
             <constraint firstAttribute="height" constant="36" id="OaO-Pb-Biu"/>
         </constraints>
         <color key="barTintColor" red="0.96862745100000003" green="0.96862745100000003" blue="0.96862745100000003" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
         <textInputTraits key="textInputTraits"/>
         <connections>
             <outlet property="delegate" destination="-1" id="2SD-E6-JdX"/>
         </connections>
     </searchBar>
     ```
     */
    case searchBar
 
    
      /** ``XibEdgeInsetsProtocol``
       
     ```xml
     <edgeInsets key="layoutMargins" top="0.0" left="10" bottom="0.0" right="10"/>
     ```
     */
    case edgeInsets
 
   /// found only in datePicker
    case locale
    
   /**
     ```xml
     <tabStops>
     <textTab alignment="left" location="28">
     <options/>
     </textTab>
     <textTab alignment="left" location="56">
     <options/>
     </textTab>
     </tabStops>
     ```
     */
    case tabStops
    case textTab
    case options
    
    /**
     ```xml
     <inset key="sectionInset" minX="0.0" minY="0.0" maxX="0.0" maxY="0.0"/>
     <inset key="imageEdgeInsets" minX="5" minY="0.0" maxX="2.2250738585072014e-308" maxY="0.0"/>
     <inset key="titleEdgeInsets" minX="-60" minY="65" maxX="0.0" maxY="0.0"/>
     <inset key="scrollIndicatorInsets" minX="20" minY="0.0" maxX="20" maxY="0.0"/>
     ```
     */
    case inset
    
   
    /**
     can be used in attributes
     ```xml
     <fragment content="分享游戏给卧底外的好友，每有一个好友点击就可以获得5金币，每天30金币封顶。（在卧底中点击无效哦）">
     <attributes>
     <paragraphStyle key="NSParagraphStyle" alignment="left" lineBreakMode="wordWrapping" baseWritingDirection="leftToRight" minimumLineHeight="20" maximumLineHeight="20" tighteningFactorForTruncation="0.0" allowsDefaultTighteningForTruncation="NO">
     <tabStops/>
     </paragraphStyle>
     </attributes>
     </fragment>
     ```
     */
    case paragraphStyle
    
    /**
     ```xml
     <pongPressGestureRecognizer allowableMovement="10" minimumPressDuration="0.5" id="Oko-0O-iMZ">
     <connections>
     <action selector="onCommentAreaLongPress:" destination="iN0-l3-epB" id="4wR-cs-wXi"/>
     </connections>
     </pongPressGestureRecognizer>
     ```
     */
    case pongPressGestureRecognizer
    /**
     ```xml
     <tapGestureRecognizer id="4wM-TH-DId">
     <connections>
     <action selector="onTapBg:" destination="-1" id="b9I-yX-RXm"/>
     </connections>
     </tapGestureRecognizer>
     ```
     ```xml
     <tapGestureRecognizer id="CkH-z0-Kwq" userLabel="Donate Gesture">
     <connections>
     <action selector="onDonateClick:" destination="-1" id="KFe-7g-mVT"/>
     </connections>
     </tapGestureRecognizer>
     ```
     ```xml
     <tapGestureRecognizer cancelsTouchesInView="NO" id="Hdl-1K-pXK">
     <connections>
     <action selector="tapAction:" destination="-1" id="dLN-mV-Fa9"/>
     </connections>
     </tapGestureRecognizer>
     ```
     */
    case tapGestureRecognizer
    /**
     the only find uses was listed below
     ```xml
     <gestureRecognizers/>
     ```
     */
    case gestureRecognizers
    
    /**
     properity parsing are context base, that they are assigned to a view
     */
    case color
    
    /**
     ```xml
     <size key="customSize" width="60" height="93"/>
     ```
     */
    case size
    
    /**
     ```xml
     <string key="text">每个人都会幻想一场</string>
     ```
     */
    case string
    
    /**
     ```xml
     <mutableString key="text">...
     </mutableString>
     ```
     */
    case mutableString
    
    /**
     The only usage of array found in these 1062 xib file is inside customFonts
     ```xml
     <customFonts key="customFonts">
         <array key="BananaPie-Semibold.otf">
             <string>BananaPie-Semibold</string>
         </array>
     </customFonts>
     ```
     */
    case array
    
    /**
     ```xml
     <customFonts key="customFonts">
         <array key="BananaPie-Semibold.otf">
             <string>BananaPie-Semibold</string>
         </array>
     </customFonts>
     ```
     */
    case customFonts
    
    /**
     ```xml
     <integer key="value" value="0"/>
     ```
     */
    case integer
    
    /**
     ```xml
     <attributedString key="attributedText">
         <fragment content="请按照下面的流程进行设置，确保自己的“无线数据”选择“WLAN与蜂窝网络”">
             <attributes>
                 <color key="NSColor" red="0.45882352941176469" green="0.45882352941176469" blue="0.45882352941176469" alpha="1" colorSpace="calibratedRGB"/>
                 <font key="NSFont" metaFont="system" size="14"/>
                 <paragraphStyle key="NSParagraphStyle" alignment="left" lineBreakMode="wordWrapping" baseWritingDirection="natural" minimumLineHeight="20" tighteningFactorForTruncation="0.0"/>
             </attributes>
         </fragment>
     </attributedString>
     ```
     */
    case attributedString
    case fragment
    case attributes // parsing environment
    /**
     - example 1
     ```xml
     <font key="NSFont" size="18" name="PingFangSC-Regular"/>
     <font key="NSFont" size="16" name=".PingFangSC-Regular"/>
     ```
     ```xml
     <font key="NSFont" metaFont="system" size="14"/>
     ```
     this tag is used under attribute environment only.
     */
    case font
    
    /**
     ```xml
     <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
     ```
     */
    case autoresizingMask
    case fontDescription
    /**
     ```xml
     <textInputTraits key="textInputTraits" returnKeyType="search"/>
     ```
     */
    case textInputTraits
    /**
     appear only once in 1062 xib files
     ```xml
     <offsetWrapper key="searchTextPositionAdjustment" horizontal="0.0" vertical="0.0"/>
     ```
     */
    case offsetWrapper
    
    /**
     in all 1062 xib file, found under imageView
     ```xml
     <imageReference key="image" image="invite_voice_logo"/>
     ```
     */
    case imageReference
    case customNil = "nil"
    /**
     upto now, found only under button
     ```xml
     <state key="normal" title="我知道了">
         <color key="titleColor" white="1" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
     </state>
     <state key="selected" image="room_pk_seat_select"/>
     ```
     */
    case state
    /**
     ```xml
     <freeformSimulatedSizeMetrics key="simulatedDestinationMetrics"/>
     ```
     */
    case freeformSimulatedSizeMetrics
    
    case userDefinedRuntimeAttributes // xml environment
    case userDefinedRuntimeAttribute
    
    /**
     ```xml
     <userDefinedRuntimeAttributes>
     <userDefinedRuntimeAttribute type="number" keyPath="radius">
     <real key="value" value="15"/>
     </userDefinedRuntimeAttribute>
     </userDefinedRuntimeAttributes>
     ```
     ```xml
     <real key="NSKern" value="-0.29999999999999999"/>
     ```
     */
    case real
    
    
    /// Constraint
    case constraint
    
    /**
     ```xml
     <variation key="default">
     <mask key="constraints">
     <exclude reference="dEh-8B-hEy"/>
     </mask>
     </variation>
     ```
     ```xml
     <variation key="heightClass=regular-widthClass=regular" constant="10"/>
     ```
     ```xml
     <variation key="heightClass=regular-widthClass=regular">
     <fontDescription key="fontDescription" name="PingFangSC-Medium" family="PingFang SC" pointSize="21"/>
     </variation>
     ```
     */
    case variation
    /**
     ```xml
     <variation key="default">
         <mask key="constraints">
             <exclude reference="YUP-qh-Nyy"/>
             <exclude reference="Zj5-Vi-9Y6"/>
         </mask>
     </variation>
     ```
     */
    case mask
    case exclude
    
    /// connections
    case connections
    
    /// action
    case action
    /**
     ```xml
     <outlet property="desLabel" destination="ZFo-UX-B1q" id="5ew-Vl-bEg"/>
     <connections>
     <outlet property="dataSource" destination="-1" id="3d3-sx-SXf"/>
     <outlet property="delegate" destination="-1" id="FVr-Xi-kTy"/>
     </connections>
     ```
     ```objc
     @property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
     @property (weak, nonatomic) IBOutlet WPCornerView *indicatorView;
     @property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorViewCenterXConstraint;
     @property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectViewCenterXConstraint;
     ```
     */
    case outlet
    /**
     outlet can be view, Array and constraint
     outlet Collections is used for mapping a list of Objects
     ```xml
     <connections>
         <outletCollection property="buttons" destination="cjF-HA-2EQ" id="amc-G7-men"/>
         <outletCollection property="buttons" destination="8x3-Zo-tcR" id="Qcv-Ps-PAY"/>
     </connections>
     ```
     ```ojbc
     @property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
     ```
     */
    case outletCollection
    
    // View Hierachy
    case subview = "subviews"
    
    /// cases to ignore
    /// - point: `<point key="canvasLocation" x="90.5" y="128.5"/>` xib tag, safe to ignore
    case point
    /// - rect: `<rect key="frame" x="0.0" y="0.0" width="320" height="568"/>`
    case rect
    /**
     ```xml
     <textView clipsSubviews="YES" multipleTouchEnabled="YES" userInteractionEnabled="NO" contentMode="scaleToFill" textAlignment="natural" translatesAutoresizingMaskIntoConstraints="NO" id="1hh-mT-vxi">
         <rect key="frame" x="16" y="20" width="268" height="95"/>
         <color key="backgroundColor" white="0.0" alpha="0.0" colorSpace="calibratedWhite"/>
         <constraints>
             <constraint firstAttribute="height" constant="95" id="YLg-E5-1zT"/>
         </constraints>
         <string key="text">签订恋爱保险需要结婚双方同意，在这里向TA发出保险申请吧！
填写前请先仔细阅读《恋爱保险协议》</string>
         <fontDescription key="fontDescription" type="system" pointSize="14"/>
         <textInputTraits key="textInputTraits" autocapitalizationType="sentences"/>
         <dataDetectorType key="dataDetectorTypes" link="YES"/>
     </textView>
     ```
     */
    case dataDetectorType
    
    /**
     ```xml
     <buttonConfiguration key="configuration" style="plain" title=" "/>
     ```
     */
    case buttonConfiguration
    
    /// - constraints: `<constraints>`
    case constraints
    
    /// xib file entrance
    case document
    
    /**
     ```xml
     <device id="retina4_7" orientation="portrait">
         <adaptation id="fullscreen"/>
     </device>
     ```
     */
    case device
    
    /// xib file tag
    case dependencies
    
    /// `<deployment identifier="iOS"/>`
    case deployment
    
    /// xib file tag
    case plugIn
    
    /// xib file tag
    case capability
    
    /// xib parsing environment
    case objects
    /**
     xib file tag
     two usage <id-1>,  <id-2>
     */
    case placeholder
    
    /// xib parsing environment
    case resources
    /**
     found only in resources
     */
    case image
    /**
     appear only in resources
     ```xml
     <systemColor name="systemBackgroundColor">
         <color white="1" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
     </systemColor>
     ```
     */
    case systemColor
    /**
     ```xml
     <viewLayoutGuide key="safeArea" id="Q5M-cg-NOt"/>
     ```
     used in constraint
     */
    case viewLayoutGuide
    case adaptation // ignored
    
    // MARK: designable environment
    case designables
    /**
     ```xml
     <designables>
     <designable name="HlU-XH-ydk">
     <size key="intrinsicContentSize" width="252" height="200"/>
     </designable>
     <designable name="rEa-gg-x3W">
     <size key="intrinsicContentSize" width="252" height="82"/>
     </designable>
     </designables>
     ```
     */
    case designable
    
    
    // MARK: MISC???
    /**
     used only once in all 1062 xib files.
     ```xml
     <resources>
     <mutableData key="keyedArchiveRepresentation">
     ...
     </>
     </image>
     </resources>
     ```
     */
    case mutableData
    
    
    /**
     ```xml
     <accessibility key="accessibilityConfiguration">
     <accessibilityTraits key="traits" notEnabled="YES"/>
     </accessibility>
     
     ```
     */
    case accessibility
    case accessibilityTraits
    
    /**
     ```xml
     <simulatedMetricsContainer key="defaultSimulatedMetrics">
         <simulatedStatusBarMetrics key="statusBar"/>
         <simulatedOrientationMetrics key="orientation"/>
         <simulatedScreenMetrics key="destination" type="retina4"/>
     </simulatedMetricsContainer>
     ```
     */
    case simulatedMetricsContainer
    case simulatedStatusBarMetrics
    case simulatedOrientationMetrics
    case simulatedScreenMetrics
    
    /**
     ```xml
     <simulatedNavigationBarMetrics key="simulatedTopBarMetrics" translucent="NO" prompted="NO"/>
     ```
     */
    case simulatedNavigationBarMetrics
    
    
}
