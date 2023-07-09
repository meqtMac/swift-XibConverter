import Foundation
import XibConverter

//print(
//    xib2Swift(
//        xibData: data,
//        className: "TestUIView",
//        superclass: "UIView"
//    )
//)


//let nativeXib = NativeXib(xibData: xmlData2)
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
//myview.printAllTagExpressionsSelfAndChild()
myview.printAllTags()
//print("""
//      "view": [
//      \t\(myview.tags.sorted().map({"\"\($0)\""}).joined(separator: ",\n\t")), ],
//      """
//)
