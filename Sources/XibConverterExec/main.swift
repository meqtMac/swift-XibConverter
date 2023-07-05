import Foundation
import XibConverter
let data = xmlData

if #available(macOS 13, *) {
    // Code for macOS 10.14 and above
    //    print("macOS version is above macOS 13")
    let duration = SuspendingClock().measure {
        
        print(
            xib2Swift(
                xibData: data,
                className: "TestUIView",
                superclass: "UIView"
            )
        )
    }
    
//    let fileHandler = FileHandle.standardError
//    try fileHandler.write(contentsOf: duration.description.data(using: .utf8)!)
    
} else {
    print(
        xib2Swift(
            xibData: data,
            className: "TestUIView",
            superclass: "UIView"
        )
    )
    
}
