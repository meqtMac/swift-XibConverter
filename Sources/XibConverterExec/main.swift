import Foundation
import XibConverter
let data = xmlData
print(
    xib2Swift(
        xibData: data,
        className: "InsuranceUIView",
        superclass: "UIView"
    )
)